class Player {
  String name = "anonymous";
  boolean human = true;
  // Card[]
  ArrayList<Card> myHand = new ArrayList();
  int myScore = 0;
  float loot = DEFAULT_BALANCE;

  Player() {
  }

  Player(String aName) {
    name = aName;
  }

  void drawHand(int x, int y) {
    // the number of pixels between card edges
    int bump = int(0.25 * (CARDW + (PAD * 5)));
    int i = 0; // count of cards drawns

    // for(int i =0; i < hand.size(); ++i
    for (Card c : myHand) {
      c.draw( x + (i * bump), y );
      i++;
    }
  }

  void addCard(Card c) {
    myHand.add(c);

    // everytime we add a card to our hand update the score
    calcScore();
  }

  void discardAll() {
    myHand.clear();

    // reset the score
    myScore = 0;
  }

  void showAll() {
    for (Card c : myHand) {
      if (!c.faceUp) {
        c.flip();
      }
    }
  }

  void hideAll() {
    for (Card c : myHand) {
      if (c.faceUp) {
        c.flip();
      }
    }
  }

  void calcScore() {
    int aceCount = 0;
    myScore = 0;

    for (Card c : myHand) {
      if (c.rank == 1) {
        aceCount++;
      } else {
        myScore += min(c.rank, 10);
      }
    }

    for (int i=0; i < aceCount; ++i) {
      if (myScore <= 10) {
        myScore += 11;
      } else {
        myScore += 1;
      }
    }
  }

  String toString() {
    return name;
  }
}
