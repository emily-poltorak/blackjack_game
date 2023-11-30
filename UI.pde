/* ------------------- */
//  UI VARIABLES
/* ------------------- */

 PImage uBusted;

final int dealerHandX = 125 ;
final int dealerHandY = 150;
final int playerHandX = 125 ;
final int playerHandY = 450;
final int playerScoreX = 75;
final int playerScoreY = 330;
final int dealerScoreX = 75;
final int dealerScoreY = 260;
final int statusBarX = 300;
final int statusBarY = 580;
// ---------------------

void drawBackground() {

  rectMode(CORNER);
  noStroke();
  //stroke(255);
  fill(255);
  // x,y of the left corner then the width height
  rect(0, 0, width, height);

  rectMode(CENTER);

  fill(15, 126, 15);
  //specify the midpoint of the rectangle
  // x,y,w,h
  rect(width * 0.5, height * 0.5, width * .90, height * .90);

  fill(0);
  textSize(16);
  textAlign(LEFT);
  text("Your current total loot: $" + String.format("%.2f", balance), 20, 20 );
  //textAlign(RIGHT);
  text("current Bet: $" + String.format("%.2f", currentBet), 410, 20 );

  if (debugStates) {
    textAlign(CENTER);
    fill(255, 0, 0);
    text(String.format("{%s}", currentState), width*0.5, 20);
  }
}



//---------------------------
//  DRAW MESSAGE
//---------------------------
void drawMessage(String message) {
  fill(0, 0, 0);
  textSize(18);
  if(currentState == START){
    textSize(16);
  }
  textAlign(CENTER, CENTER);
  text(message, statusBarX, statusBarY);
}


//---------------------------
//  DRAW PlayersHands
//---------------------------
void drawPlayersHands() {
  //draw the dealers hand and players hand
  dealer.drawHand(dealerHandX, dealerHandY);
  player.drawHand(playerHandX, playerHandY);

  if (shouldShowDealersCards) {
    showDealerScore();
  }
  showPlayerScore();
}


//---------------------------
//  Show PlayerScore
//---------------------------
void showPlayerScore() {
  textSize(24);
  textAlign(LEFT, CENTER);
  text(Integer.toString(player.myScore), playerScoreX, playerScoreY);
}

//---------------------------
//  Show DealerScore
//---------------------------
void showDealerScore() {
  textSize(24);
  textAlign(LEFT, CENTER);
  text(Integer.toString(dealer.myScore), dealerScoreX, dealerScoreY);
}
