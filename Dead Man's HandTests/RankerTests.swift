//
//  Dead_Man_s_HandTests.swift
//  Dead Man's HandTests
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import XCTest
@testable import Dead_Man_s_Hand

class Dead_Man_s_HandTests: XCTestCase {
    func testPokerGame_DoesntRetain_Player() {
        let pokerGame = PokerGameSpy()
        let player = pokerGame.player1
        
        assertNoMemoryLeak(player)
        assertNoMemoryLeak(pokerGame)
    }
}

private class PokerGameSpy: CardGame {
    var deck = Deck()
    var player1: Player
    var player2: Player
    
    var highHand: WinningHandType!
    var winningPlayer: Player!
    var highCard: Card!
    
    lazy var ranker = HandRanker(player1: player1, player2: player2)
    
    init() {
        self.player1 = Player(name: "Player 1")
        self.player2 = Player(name: "Player 2")
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
    
    func playHands() {
        let winner = ranker.highHand()
        highHand = winner.rank
        winningPlayer = winner.player
        highCard = winningPlayer.hand!.highCard()
    }
    
    
}
