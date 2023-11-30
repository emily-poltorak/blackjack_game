/* STATE NAMES */


// this is a flag that we can use to run some of the code that
// we want to run only once when we enter a state
boolean enteringState = false;


// game States
// create initial values for all of the game data here
final String INIT = "initializationState";
// handle all of the details of starting the game
final String START = "startState";
// deal the intial cards to the player and dealer
final String INITIAL_DEAL = "initialDealState";
// return to this state whenever we need to deal a card except the initial deal
final String DEAL = "dealState";
// prompt the player for their choice
final String HIT_STAND = "hitOrStandState";
// when the dealer goes
final String DEALERS_TURN = "dealersTurnState";
// after a hand has been played see if the user wants to continue
final String CONTINUE = "continueState";
// exit screen
final String GAMEOVER = "gameOverState";
// player gets 21
final String BLACKJACK = "blackJackState";
// player busts
final String BUSTJACK = "bustState";
// dealer beats the player
final String LOSTSTATE = "lostState";
// player beats the dealer
final String WONSTATE = "wonState";
// player ties the dealer
final String PUSH = "pushState";

/* --- END STATE NAMES ---  */



// functions to run the logic in different states

// -------------------------
//      InitState
// -------------------------
void runInitState() {

  // initialize balance
  balance = DEFAULT_BALANCE - DEFAULT_BET;
  // initialize the default bet
  currentBet = DEFAULT_BET;


  // draw the background for this state
  drawBackground();

  // print the status bar message for this state
  drawMessage("Press the SPACE key to let me start taking your money!");

  // look at the UI Flags to figure out if we need to change
  // states
  if (spaceBarPressed) {
    // lower the flag because I am going to 'process' this event now
    spaceBarPressed = false;
    changeState(START);
  }
}


// -------------------------
//      StartState
// -------------------------
void runStartState() {
  // draw the background for this state
  drawBackground();


  // print the status bar message for this state
  drawMessage("Press UP to increase bet, DOWN to decrease bet, a to go all in! and SPACE to start playing");

  if (upPressed) {
    upPressed = false;

    //change the bet...
    currentBet += betIncrement;

    //... now check the change to see if we are in the correct range
    if (balance > 0 ) {
      // subtract the players balance..
      balance -= betIncrement;
    } else {
      // take away the bet we just made because it
      // will make us go over our balance
      currentBet -= betIncrement;
    }
  }

  if (downPressed) {
    downPressed = false;
    currentBet -= betIncrement;
    if (currentBet <= 0 ) {
      // you have to bet something positive
      // so add back the betIncrement
      currentBet += betIncrement;
    } else {
      balance += betIncrement;
    }
  }

  if (aPressed) {
    aPressed = false;

    if (balance == 0) {
    } else {
      currentBet += balance;
      balance -= balance;
    }
  }


  if (spaceBarPressed) {
    // lower the flag because I am going to 'process' this event now
    spaceBarPressed = false;
    changeState( INITIAL_DEAL);
  }
}



// -------------------------
//      InitialDealState
// -------------------------
void runInitialDealState() {
  drawBackground();

  // print the status bar message for this state
  drawMessage("Press 'h' to HIT or 's' to STAND");


  if (enteringState) {

    player.addCard(deck.dealACard());
    player.addCard(deck.dealACard());


    dealer.addCard(deck.dealACard());
    dealer.addCard(deck.dealACard().flip());

    enteringState = false;
  }

  dealer.drawHand(dealerHandX, dealerHandY);
  player.drawHand(playerHandX, playerHandY);

  text(player.myScore, playerScoreX, playerScoreY);


  // display the dealers cards. One face up...
  // ... one face down ...

  // display the Player's Cards...


  // ---- State Logic ----
  // handle the User Input
  if (hPressed) {
    hPressed = false;
    playerNeedsACard = true;
    changeState(DEAL);
  }

  if (sPressed) {
    sPressed = false;
    changeState(DEALERS_TURN);
  }

  if (player.myScore==21) {
    changeState(BLACKJACK);
  }
}


// -------------------------
//      DealState
// -------------------------
void runDealState() {
  drawBackground();

  // print the status bar message for this state
  drawMessage("Press 'h' to HIT or 's' to STAND");

  // add a card to the player's hand
  if (playerNeedsACard) {
    // add a card to the players hand
    println("We will add to the player's hand with one card");

    player.addCard(deck.dealACard());

    // LOWER the flag for them needing a card because we just gave them one
    playerNeedsACard = false;
  }

  setups();



  // then ask them if they want to hit or stand?

  // ---- State Logic ----
  // handle the User Input
  if (hPressed) {
    hPressed = false;
    playerNeedsACard = true;
  }

  if (sPressed) {
    sPressed = false;
    changeState(DEALERS_TURN);
  }

  if (player.myScore==21) {
    changeState(DEALERS_TURN);
  }
  if (player.myScore >21) {
    changeState(BUSTJACK);
  }
}

// -------------------------
//      RunHitStandState
// -------------------------
void runHitStandState() {
  drawBackground();

  // print the status bar message for this state


  // ---- State Logic ----
  // handle the User Input
}

// -------------------------
//      DealersTurnState
// -------------------------
void runDealersTurnState() {
  drawBackground();
  dealer.showAll();


  while (dealer.myScore<17) {
    dealer.addCard(deck.dealACard());
  }

  if (dealer.myScore == 21) {
    changeState(LOSTSTATE);
  }

  if (dealer.myScore > player.myScore&&dealer.myScore<21) {
    changeState(LOSTSTATE);
  }

  if (dealer.myScore < player.myScore||dealer.myScore>21) {
    changeState( WONSTATE);
  }

  if (dealer.myScore == player.myScore) {
    changeState(PUSH);
  }



  // print the status bar message for this state


  // ---- State Logic ----
  // handle the User Input
}


// -------------------------
//      ContinueState
// -------------------------
void runContinueState() {
  drawBackground();

  // print the status bar message for this state

  // ---- State Logic ----
  // handle the User Input
}


// -------------------------
//      GameOverState
// -------------------------
void runGameOverState() {
  drawBackground();

  setups();

  fill(0);
  text("lol you lost all your money. Press SPACE to start over.", statusBarX, statusBarY +7);

  if (spaceBarPressed&&balance ==0) {
    reset();
    changeState(INIT);
  }




  // print the status bar message for this state

  // ---- State Logic ----
  // handle the User Input
}

// -------------------------
//      BlackJackState
// -------------------------
void runBlackJackState() {
  drawBackground();
  setups();

  dealer.showAll();
  if (dealer.myScore == 21) {
    if (enteringState) {
      balance += currentBet;
      text("You had blackjack and so did the dealer, you push", statusBarX, statusBarY+7);
    }
  } else {


    setups();
    text("Good job you won purely out of luck, press SPACE to start again", statusBarX, statusBarY + 7);
    // print the status bar message for this state


    if (enteringState) {
      balance += currentBet + (currentBet * 3/2);
      currentBet = 0;
    }
  }




  if (spaceBarPressed) {
    changeState(START);
    spaceBarPressed = false;
    player.discardAll();
    dealer.discardAll();
  }
}

// ---- State Logic ----
// handle the User Input



// -------------------------
//      BustState
// -------------------------
void runBustState() {
  
  drawBackground();

  fill(0);
  text("You busted loser, press SPACE to start again", statusBarX, statusBarY+7);
  // print the status bar message for this state
  
   setups();

imageMode(CENTER);
  image(uBusted, 300, 300, 400, 400);



  if (balance == 0) {
    changeState(GAMEOVER);
  }

  currentBet = 0;

  if (spaceBarPressed) {
    changeState(START);
    spaceBarPressed = false;
    player.discardAll();
    dealer.discardAll();
  }



  // ---- State Logic ----
  // handle the User Input
}


// -------------------------
//      LostState
// -------------------------
void runLostState() {
  drawBackground();

  setups();
  if (dealer.myScore !=21) {
    text("The dealer had a higher score, you lost loser, press SPACE to start again", statusBarX, statusBarY+7);
  } else {
    fill(0);
    text("The Dealer got blackjack Press SPACE to start again.", statusBarX, statusBarY +7);
  }

  // print the status bar message for this state

  // ---- State Logic ----
  // handle the User Input

  if (balance == 0) {
    changeState(GAMEOVER);
  }

  currentBet = 0;


  if (spaceBarPressed) {
    changeState(START);
    spaceBarPressed = false;
    player.discardAll();
    dealer.discardAll();
  }

  setups();
}

// -------------------------
//      WonState
// -------------------------
void runWonState() {
  drawBackground();

  setups();
  text("You Won good job, press SPACE to start again", statusBarX, statusBarY+7);

  if (enteringState) {
    balance = balance + currentBet * 2;
    currentBet = 0;
  }

  if (spaceBarPressed) {
    changeState(START);
    spaceBarPressed = false;
    player.discardAll();
    dealer.discardAll();
  }
}

// print the status bar message for this state

// ---- State Logic ----
// handle the User Input


// -------------------------
//      PushState
// -------------------------
void runPushState() {
  drawBackground();

  setups();
  text("You Had the same amount as the dealer, press SPACE to start again", statusBarX, statusBarY+7);

  if (enteringState) {
    balance = balance + currentBet;
    currentBet = 0;
  }

  if (spaceBarPressed) {
    changeState(START);
    spaceBarPressed = false;
    player.discardAll();
    dealer.discardAll();
  }

  // print the status bar message for this state

  // ---- State Logic ----
  // handle the User Input
}


// Call this function to change states
void changeState(String nextState) {
  // set this flag so that if the state wants to run any code
  // when we first enter it we can
  // this allows the states to run set up code
  println("{changeState} ", currentState, " -> ", nextState);
  enteringState = true;
  currentState = nextState;
}
