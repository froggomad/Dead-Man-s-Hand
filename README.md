# Welcome to Dead Man's Hand
### A Fun 2 Player Poker Game

# Rules
Traditional Poker rules for ranking hands - 5 card stud

# Architecture
![MVC](https://i.ibb.co/W64VR23/Screen-Shot-2021-08-25-at-12-30-55-PM.png)

- `Card` is composed of a suit and rank
  - `Deck`depends on `Card` in order to give players a place to draw random cards from
  - `Hand` depends on `Card` to form a valid poker hand  
    - `Player` depends on `Hand` in order to have a valid hand
      - `HandRanker` depends on `Player` in order to have valid hands to rank      
        - `CardGame` protocol requires a HandRanker and deck
        
I'm not positive the best decision is for `CardGame` to require a HandRanker and deck... 
rather than players, HandRanker, and deck - and for HandRanker to get its players from CardGame

# UI (Coming Soon!)

# How to Play! (Run the rules engine)
In order to play, the game requires a `HandRanker` and `Deck` be instantiated.

```swift
let ranker = HandRanker(player1: "Player1", player2: "Player2")
let deck = Deck()
```

Then a CardGame can be created. `CardGameSpy` in the unit tests is a good starting point.

Saying you created a CardGame conformer called PokerGame, you'll just need to draw hands and play!
```swift
let pokerGame = PokerGame(ranker: ranker, deck: deck)
pokerGame.drawHands()
pokerGame.playHands()
```

`playHands` should use the ranker to compare the player's hands and return the resulting Winning Hand Type (ex: pair) the highest rank (ex: ace) and the Winning Player

# Have Fun!!
