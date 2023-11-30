/* GLOBAL VARIABLES */
float DEFAULT_BET = 0;
float DEFAULT_BALANCE = 1000;
boolean debugStates = true;
float balance;
float currentBet = DEFAULT_BET;
float lastBet = 0;
// keep track of profit and loss for the current round
float recentPL = 0;

float betIncrement = 100;
float angle;
 float jitter;

String currentState;
// ---- Variables for the game
Deck deck;
Player player, dealer;



// ----- END GLOBALS ---- //

// **FLAGS**
// Flags help us track the status of the Game/App
boolean spaceBarPressed = false;
boolean upPressed = false;
boolean downPressed = false;
boolean hPressed = false;
boolean sPressed = false;
boolean qPressed = false;
boolean playerNeedsACard = false;
boolean shouldShowDealersCards = false;
boolean hasBlackJack = false;
boolean aPressed = false;



// ----- END FLAGS ---- //


void setup() {
  size(600, 600);

  //initialize the state
  currentState = INIT;
  initializePerry();
  initializeCards();
  initializePlayers();
}

void draw() {
  background(0);

  run();
}

//--------------------------
//   run
//   this is where the magic happens...depending on the
//   current state of the game a different function will run...
//--------------------------
void run() {
  switch(currentState) {

  case INIT:
    runInitState();
    break;

  case START:
    runStartState();
    break;

  case INITIAL_DEAL:
    runInitialDealState();
    break;

  case DEAL:
    runDealState();
    break;

  case HIT_STAND:
    runHitStandState();
    break;

  case DEALERS_TURN:
    runDealersTurnState();
    break;

  case CONTINUE:
    runContinueState();
    break;

  case GAMEOVER:
    runGameOverState();
    break;

  case BLACKJACK:
    runBlackJackState();
    break;

  case BUSTJACK:
    runBustState();
    break;

  case WONSTATE:
    runWonState();
    break;

  case LOSTSTATE:
    runLostState();
    break;

  case PUSH:
    runPushState();
    break;

  default:
    println("UNKNOWN STATE!! THIS IS AN ERROR SHOULD NOT GET HERE EVER!! currentState = ", currentState, "...exiting");
    exit();
  }
}



void keyPressed() {
  // This is to detect whether or not the key the user pressed is a special
  // CODED key...like ALT SHIFT or the ARROW Keys
  if (key == CODED ) {
    switch(keyCode) {
    case UP:
      upPressed = true;
      break;

    case DOWN:
      downPressed = true;
      break;
    default:
      println("I am ignoring this unknown keyboard input: " + keyCode);
    }
  } else {

    switch (key) {
    case ' ':
      spaceBarPressed = true;
      break;

    case 'a':
    case 'A':
      aPressed = true;
      break;


    case 'h':
    case 'H':
    if(currentState == INITIAL_DEAL||currentState == DEAL){
      hPressed = true;
    }
      break;

    case 's':
    case 'S':
    if(currentState == INITIAL_DEAL||currentState == DEAL){
      sPressed = true;
    }
      break;

    case 'q':
    case 'Q':
      qPressed = true;
      break;
    default:
      println("I am ignoring this unknown keyboard input: " + key);
    }
  }
}
