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
    
    func testHighestStraightFlush_wins() {
        guard let losingHand = Hand(cards: [
            Card(suit: .hearts, rank: .two),
            Card(suit: .hearts, rank: .three),
            Card(suit: .hearts, rank: .four),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six)
        ]),
        let winningHand = Hand(cards: [
            Card(suit: .spades, rank: .king),
            Card(suit: .spades, rank: .ace),
            Card(suit: .spades, rank: .ten),
            Card(suit: .spades, rank: .queen),
            Card(suit: .spades, rank: .jack)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .straightFlush)
    }
    
    func testStraightFlush_winsOver_fourOfAKind() {
        guard let winningHand = Hand(cards: [
            Card(suit: .hearts, rank: .two),
            Card(suit: .hearts, rank: .three),
            Card(suit: .hearts, rank: .four),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six)
        ]),
        let losingHand = Hand(cards: [
            Card(suit: .spades, rank: .ace),
            Card(suit: .diamonds, rank: .ace),
            Card(suit: .clubs, rank: .ace),
            Card(suit: .hearts, rank: .ace),
            Card(suit: .diamonds, rank: .jack)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .straightFlush)
    }
    
    func testHighFourOfAKind_winsOver_lowFourOfAKind() {
        guard let winningHand = Hand(cards: [
            Card(suit: .spades, rank: .ace),
            Card(suit: .hearts, rank: .ace),
            Card(suit: .hearts, rank: .two),
            Card(suit: .diamonds, rank: .ace),
            Card(suit: .clubs, rank: .ace)
        ]),
        let losingHand = Hand(cards: [
            Card(suit: .spades, rank: .jack),
            Card(suit: .diamonds, rank: .jack),
            Card(suit: .clubs, rank: .jack),
            Card(suit: .hearts, rank: .jack),
            Card(suit: .diamonds, rank: .three)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .fourOfAKind)
    }
    
    func testFourOfAKind_winsOver_fullHouse() {
        guard let losingHand = Hand(cards: [
            Card(suit: .spades, rank: .two),
            Card(suit: .hearts, rank: .ace),
            Card(suit: .hearts, rank: .two),
            Card(suit: .spades, rank: .ace),
            Card(suit: .clubs, rank: .ace)
        ]),
        let winningHand = Hand(cards: [
            Card(suit: .spades, rank: .jack),
            Card(suit: .diamonds, rank: .jack),
            Card(suit: .clubs, rank: .jack),
            Card(suit: .hearts, rank: .jack),
            Card(suit: .diamonds, rank: .ace)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .fourOfAKind)
    }
    
    func testFullHouse_winsOver_flush() {
        guard let winningHand = Hand(cards: [
            Card(suit: .spades, rank: .two),
            Card(suit: .hearts, rank: .ace),
            Card(suit: .hearts, rank: .two),
            Card(suit: .spades, rank: .ace),
            Card(suit: .clubs, rank: .ace)
        ]),
        let losingHand = Hand(cards: [
            Card(suit: .hearts, rank: .two),
            Card(suit: .hearts, rank: .three),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six),
            Card(suit: .hearts, rank: .seven)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .fullHouse)
    }
    
    func testHighestFlush_wins() {
        guard let winningHand = Hand(cards: [
            Card(suit: .spades, rank: .ace),
            Card(suit: .spades, rank: .three),
            Card(suit: .spades, rank: .four),
            Card(suit: .spades, rank: .eight),
            Card(suit: .spades, rank: .two)
        ]),
        let losingHand = Hand(cards: [
            Card(suit: .hearts, rank: .two),
            Card(suit: .hearts, rank: .three),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six),
            Card(suit: .hearts, rank: .seven)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .flush)
    }
    
    func testFlush_winsOver_straight() {
        guard let winningHand = Hand(cards: [
            Card(suit: .hearts, rank: .two),
            Card(suit: .hearts, rank: .three),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six),
            Card(suit: .hearts, rank: .seven)
        ]),
            let losingHand = Hand(cards: [
            Card(suit: .spades, rank: .two),
            Card(suit: .hearts, rank: .three),
            Card(suit: .hearts, rank: .four),
            Card(suit: .spades, rank: .five),
            Card(suit: .clubs, rank: .six)
        ])
        
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .flush)
    }
    
    func testEqualStraightIsTie() {
        // TODO: refactor helper function to handle ties
    }
    
    func testStraight_winsOver_threeOfAKind() {
        guard let winningHand = Hand(cards: [
            Card(suit: .spades, rank: .two),
            Card(suit: .hearts, rank: .three),
            Card(suit: .hearts, rank: .four),
            Card(suit: .spades, rank: .five),
            Card(suit: .clubs, rank: .six)
        ]),
        let losingHand = Hand(cards: [
            Card(suit: .hearts, rank: .ace),
            Card(suit: .clubs, rank: .ace),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six),
            Card(suit: .spades, rank: .ace)
        ])
        else { return }
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .straight)
    }
    
    func test3OfAKind_winsOver_twoPair() {
        guard let losingHand = Hand(cards: [
            Card(suit: .spades, rank: .two),
            Card(suit: .hearts, rank: .two),
            Card(suit: .hearts, rank: .four),
            Card(suit: .spades, rank: .five),
            Card(suit: .clubs, rank: .four)
        ]),
        let winningHand = Hand(cards: [
            Card(suit: .hearts, rank: .ace),
            Card(suit: .clubs, rank: .ace),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six),
            Card(suit: .spades, rank: .ace)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .threeOfAKind)
    }
    
    func testTwoPair_winsOver_pair() {
        guard let winningHand = Hand(cards: [
            Card(suit: .spades, rank: .two),
            Card(suit: .hearts, rank: .two),
            Card(suit: .hearts, rank: .four),
            Card(suit: .spades, rank: .five),
            Card(suit: .clubs, rank: .four)
        ]),
        let losingHand = Hand(cards: [
            Card(suit: .hearts, rank: .ace),
            Card(suit: .clubs, rank: .ace),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six),
            Card(suit: .spades, rank: .seven)
        ])
        else { return }
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .twoPair)
    }
    
    // Note, there appears to be an error with this test
    // setup as both hands contain a pair of aces but the
    // notes say "The highest pair wins"
    func testHighPairWins() {
        guard let losingHand = Hand(cards: [
            Card(suit: .spades, rank: .six),
            Card(suit: .diamonds, rank: .ace),
            Card(suit: .hearts, rank: .seven),
            Card(suit: .spades, rank: .four),
            Card(suit: .spades, rank: .ace)
        ]),
        
        let winningHand = Hand(cards: [
            Card(suit: .hearts, rank: .ace),
            Card(suit: .clubs, rank: .ace),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six),
            Card(suit: .spades, rank: .seven)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .pair)
    }
    
    func testPairWins_over_dud() {
        guard let losingHand = Hand(cards: [
            Card(suit: .spades, rank: .two),
            Card(suit: .hearts, rank: .ace),
            Card(suit: .hearts, rank: .four),
            Card(suit: .spades, rank: .five),
            Card(suit: .clubs, rank: .king)
        ]),
        
        let winningHand = Hand(cards: [
            Card(suit: .hearts, rank: .ace),
            Card(suit: .clubs, rank: .ace),
            Card(suit: .hearts, rank: .five),
            Card(suit: .hearts, rank: .six),
            Card(suit: .spades, rank: .seven)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .pair)
    }
    
    func testHighPair_wins() {
        guard let losingHand = Hand(cards: [
            Card(suit: .clubs, rank: .eight),
            Card(suit: .spades, rank: .four),
            Card(suit: .hearts, rank: .king),
            Card(suit: .spades, rank: .jack),
            Card(suit: .diamonds, rank: .four)
        ]),
        
        let winningHand = Hand(cards: [
            Card(suit: .clubs, rank: .king),
            Card(suit: .hearts, rank: .four),
            Card(suit: .spades, rank: .king),
            Card(suit: .spades, rank: .jack),
            Card(suit: .diamonds, rank: .ace)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .pair)
    }
    
    func testHighCard_winsOver_lowCard() {
        guard let losingHand = Hand(cards: [
            Card(suit: .hearts, rank: .jack),
            Card(suit: .spades, rank: .eight),
            Card(suit: .hearts, rank: .ten),
            Card(suit: .hearts, rank: .ace),
            Card(suit: .hearts, rank: .queen)
        ]),
        let winningHand = Hand(cards: [
            Card(suit: .diamonds, rank: .king),
            Card(suit: .spades, rank: .six),
            Card(suit: .diamonds, rank: .nine),
            Card(suit: .hearts, rank: .ten),
            Card(suit: .diamonds, rank: .ace)
        ])
        else { return }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .highCard)
    }
    
    private func testHands(winningHand: Hand, losingHand: Hand, expectedHandRank: WinningHandType, file: StaticString = #file, line: UInt = #line) {
        let pokerGame = PokerGameSpy()
        pokerGame.player2.hand = losingHand
        pokerGame.player1.hand = winningHand
        pokerGame.playHands()
        
        XCTAssertEqual(pokerGame.highHand, expectedHandRank, file: file, line: line)
        XCTAssertEqual(pokerGame.highCard?.rank, winningHand.cards.last!.rank, file: file, line: line)
        XCTAssertEqual(pokerGame.winningPlayer?.name, pokerGame.player1.name, file: file, line: line)
    }
}

private class PokerGameSpy: CardGame {
    var deck = Deck()
    
    var highHand: WinningHandType?
    var winningHand: Hand?
    var winningPlayer: Player?
    var highCard: Card?
    
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
    
    @discardableResult func playHands() -> WinningHand {
        let highHand = ranker.highHand()
        switch highHand {
        case .win(let rank, let player):
            winningHand = player.hand!
            self.highHand = rank
            winningPlayer = player
            guard let hand = player.hand else { return .tie }
            highCard = ranker.highestCard(hand)
        case .tie:
            return .tie
        }
        return .tie
    }
    
    
}
