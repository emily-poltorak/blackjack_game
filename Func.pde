
// ----------------------
// Initialize the cards
// ----------------------
void initializeCards() {


  imageMode(CENTER);

  spriteSheet = loadImage("spriteSheet.png");
  spriteSheet.loadPixels();

  // initialize the Card backs
  int xCoord = (CARDBACK_COL % 13) * (CARDW + PAD);
  int yCoord = CARDBACK_ROW * (CARDH + PAD);

  cardBack = spriteSheet.get(xCoord, yCoord, CARDW, CARDH );

  deck = new Deck();
}

// ----------------------
// Initialize Players
// ----------------------
void initializePlayers() {
  player = new Player();
  dealer = new Player();
}


// ----------------------
// Reset all of the variables and what not
// to their original states
// ----------------------
void reset() {
  player.discardAll();
  dealer.discardAll();
  shouldShowDealersCards = false;
  aPressed = false;
  spaceBarPressed = false;
  upPressed = false;
  downPressed = false;
  hPressed = false;
  sPressed = false;
  playerNeedsACard = false;

  // a flag to track if we have already initialized the deck
  // and the players hands for this round
  currentBet = lastBet;
  recentPL = 0;
}


// -------
// --- for testing it is helpful to be able to set the hand of a player
// -------
void fakeDeal(Player p, Card...cards) {
  println("Just a reminder that we are fake dealing, player: ", p);
  for (Card c : cards) {
    p.addCard(c);
  }
}

void setups() {

  fill(0);
  dealer.drawHand(dealerHandX, dealerHandY);
  player.drawHand(playerHandX, playerHandY);

  text(player.myScore, playerScoreX, playerScoreY);

  if (currentState==DEALERS_TURN||currentState==WONSTATE||currentState==PUSH||currentState==LOSTSTATE||currentState == BLACKJACK||currentState == GAMEOVER) {
    text(dealer.myScore, dealerScoreX, dealerScoreY);
  }
}

void initializePerry(){
  uBusted = loadImage("YouBusted.jpeg");
  uBusted.loadPixels();
}
