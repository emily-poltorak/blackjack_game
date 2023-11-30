//  -----------------------
//  Variables for Cards
PImage spriteSheet;
PImage cardBack;
PImage busted;

// - variables for selecting the card back to use
final int CARDBACK_ROW = 4;
// 0-3 = blue cards
// 4-7 = green cards
// ...
final int CARDBACK_COL = 5; // some value between 0 -12

final int CARDW = 140;
final int CARDH = 190;
final int PAD = 1;
//  -----------------------

class Deck {
  ArrayList<Card> cards = new ArrayList();

  //constructor- make a deck
  Deck() {
    createDeck();
  }

  //method that actualy populates the cards in an array
  //also this method will automatically shuffle the cards when you call it
  void createDeck() {
    //incarse there are any cards in the array clear them out before making a new deck
    cards.clear();
    for (int i=0; i < 52; ++i) {
      //cards[i] = new Card(i);
      cards.add( new Card(i) );
    }

    shuffle();
  }

  //---------------------
  // dealACard
  //---------------------
  Card dealACard() {
    if ( cards.size() == 0 ) {
      createDeck();
    }
    //cards[i]
    Card c = cards.get( cards.size() - 1 );
    cards.remove(c);
    return c;
  }

  //---------------------
  // shuffle
  //---------------------
  void shuffle() {
    // our quick implementation of the fisher yates shuffle algorithm
    Card temp;

    for (int i = cards.size() - 1; i > 0; i--) {
      temp = cards.get(i);
      int randIndex = int(random(i-1));
      Card toSwap = cards.get(randIndex);
      cards.set(i, toSwap);
      cards.set(randIndex, temp);
    }
  }
}

class Card {
  int rank;
  PImage img;
  boolean faceUp = true;  // by default cards will be facing up

  Card(int r) {
    rank = (r % 13) + 1;

    int xCoord = (r % 13) * (CARDW + PAD);
    int yCoord = (r / 13) * (CARDH + PAD);
    img = spriteSheet.get(xCoord, yCoord, CARDW, CARDH );
  }

  void draw(int x, int y) {
    imageMode(CENTER);

    if (faceUp) {
      image(img, x, y);
    } else {
      image(cardBack, x, y);
    }
  }

  // toggle the card to be either face up or down
  // return the card when done. This is done as a convenience
  // it makes the code easier to use in some situations
  Card flip() {
    faceUp = !faceUp;
    return this;
  }
}
