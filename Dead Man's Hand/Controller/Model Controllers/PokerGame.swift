//
//  PokerGame.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import Foundation

class PokerGame: CardGame {
    var deck = Deck()
    var ranker: HandRanker
    
    lazy var player1 = ranker.player1
    lazy var player2 = ranker.player2
    
    init() {
        ranker = HandRanker(player1: Player(name: "Player 1"), player2: Player(name: "Player 2"))
    }
    
    
    func drawHands() {
        if deck.count < 10 {
            deck.refresh()
            drawHand(player: player1)
            drawHand(player: player2)
        } else {
            drawHand(player: player1)
            drawHand(player: player2)
        }
    }
    
    private func drawHand(player: Player) {
        
        var cards: [Card] = []
        (1...5).forEach { _ in
            cards.append(deck.drawCard())
        }
        player.hand = .init(cards: cards)
        
    }
    
    func playHands() -> WinningHand {
        ranker.highHand()
    }
    
    
}
