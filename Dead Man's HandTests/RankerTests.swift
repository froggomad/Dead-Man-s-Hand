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
    
    func testHighCard_beatsLowCard() {
        let pokerGame = PokerGameSpy()
        
        let losingHand = Hand(cards: [
            Card(suit: .hearts, rank: .jack),
            Card(suit: .spades, rank: .eight),
            Card(suit: .hearts, rank: .ten),
            Card(suit: .hearts, rank: .ace),
            Card(suit: .hearts, rank: .queen)
        ])
        
        let winningHand = Hand(cards: [
            Card(suit: .diamonds, rank: .king),
            Card(suit: .spades, rank: .six),
            Card(suit: .diamonds, rank: .nine),
            Card(suit: .hearts, rank: .ten),
            Card(suit: .diamonds, rank: .ace)
        ])
        
        pokerGame.player2.hand = losingHand
        pokerGame.player1.hand = winningHand
        pokerGame.playHands()
        
        XCTAssertEqual(pokerGame.highHand, .highCard)
        XCTAssertEqual(pokerGame.highCard?.rank, winningHand!.highCard().rank)
        XCTAssertEqual(pokerGame.winningPlayer?.name, pokerGame.player1.name)
    }
}

private class PokerGameSpy: CardGame {
    var deck = Deck()
    var player1: Player
    var player2: Player
    
    var highHand: WinningHandType?
    var winningHand: Hand?
    var winningPlayer: Player?
    var highCard: Card?
    
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
        let highHand = ranker.highHand()
        switch highHand {
        case .win(let rank, let player):
            winningHand = player.hand!
            self.highHand = rank
            winningPlayer = player
            highCard = player.hand!.highCard()
        case .tie:
            break
        }
    }
    
    
}
