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

# UI (Coming Soon!) -
- UI will consist of a single ViewController with the app's title at top and a `Deal` button under where the player's cards will be shown and a `Reveal` button toward the center of the view which will initially be hidden
  - player's cards will be "face up" in the lower portion of the screen
  - opponent's cards will be "face down" in the upper portion of the screen
- Card will be given a computed property `color: UIColor`:
```swift
lazy var color: UIColor = {
        switch suit {
        case .clubs, .spades:
            return .black
        case .hearts, .diamonds:
            return .red
        }
    }()
```
- Images for each suit will be added to `assets.xcassets`
  - a `suitImage: UIImage` property will be added to the `Card` struct and a computed property will be created similar to `var color: UIColor`
- a `CardView: UIView` class will be created that has a `card: Card` property it will use to setup its views
  - top left and bottom right: vertical stackView consisting of a label containing the rank and image containing the suit
  - cornerRadius set to 10
  - height set to twice the width
- a `CardBackView: UIView` class will be created that just has an image displaying the card's back
- When a player taps `Deal`, a `CardView` will be created for each of the player's cards and added to an area of the view consisting of the player's hand
- 5 `CardBackView` views will be created and placed in the opponent's area
- The `Reveal` button will be added to the view
- When a player taps `Reveal` their opponents cards will be replaced with a `CardView`, revealing the opponent's hand
- The reveal button will be hidden
- A sound will be played and a label revealed showing whether the player won or lost

# How to Play! (Run the rules engine)
`PokerGame` has been created for you using the `CardGame` protocol. Feel free to customize this or implement your own game - be sure to also subclass `HandRanker` to fit your new rules!

In order to play, create 2 players and a PokerGame
```swift
let player1 = Player(name: "Player 1")
let player2 = Player(name: "Player 2")
let pokerGame = PokerGame(player1: player1, player2: player2)
```
`playHands` should use the ranker to compare the player's hands and return the resulting Winning Hand Type (ex: pair) the highest rank (ex: ace) and the Winning Player
```swift
pokerGame.drawHands()
let winningResult = pokerGame.playHands()

switch winningResult {
case .win(let rank, let player):
  print(player)
  print(rank) // prints type of hand, ex: Pair
case .tie:
  print("You Tied!")
}
```
# note: Some tradeoffs were made!
I typically avoid using classes unless I need the features of a class. That said, it's much less cumbersome to track mutating state when a class is involved rather than a struct, so I went in that direction with the player.

It's noted in the architecture section that I'm unsure of where to put the players, but the solution I have is working.

If I had additional time to work on the project, I'd complete the UI. 

I would also further separate the rules engine by making it a framework. That way other games could be created by subclassing `HandRanker` and implementing a new `CardGame`. It could then be attached to any UI. One major benefit of this approach is testing time. Since UIKit isn't a dependency of anything that would be in the framework, it could be created as a macOS framework. This eliminates the need for a simulator which dramatically decreases testing time for a lot of projects.

# Time Taken
I spent 5.5 hours on this project including UI documentation
[Toggl_time_entries](https://github.com/froggomad/Dead-Man-s-Hand/files/7061489/Toggl_time_entries_2021-08-23_to_2021-08-29.pdf)

# Have Fun!!
_____________
