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
        guard let losingHand = parseHand(hand: "2H 3H 4H 5H 6H"),
              let winningHand = parseHand(hand: "KS AS TS QS JS")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .straightFlush)
    }
    
    func testStraightFlush_winsOver_fourOfAKind() {
        guard let winningHand = parseHand(hand: "2H 3H 4H 5H 6H"),
              let losingHand = parseHand(hand: "AS AD AC AH JD")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .straightFlush)
    }
    
    func testHighFourOfAKind_winsOver_lowFourOfAKind() {
        guard let winningHand = parseHand(hand: "AS AH 2H AD AC"),
              let losingHand = parseHand(hand: "JS JD JC JH 3D")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .fourOfAKind)
    }
    
    func testFourOfAKind_winsOver_fullHouse() {
        guard let losingHand = parseHand(hand: "2S AH 2H AS AC"),
        let winningHand = parseHand(hand: "JS JD JC JH AD")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .fourOfAKind)
    }
    
    func testFullHouse_winsOver_flush() {
        guard let winningHand = parseHand(hand: "2S AH 2H AS AC"),
              let losingHand = parseHand(hand: "2H 3H 5H 6H 7H")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .fullHouse)
    }
    
    func testHighestFlush_wins() {
        guard let winningHand = parseHand(hand: "AS 3S 4S 8S 2S"),
              let losingHand = parseHand(hand: "2S 3H 4H 5S 6C")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .flush)
    }
    
    func testFlush_winsOver_straight() {
        guard let winningHand = parseHand(hand: "2H 3H 5H 6H 7H"),
              let losingHand = parseHand(hand: "2S 3H 4H 5S 6C")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .flush)
    }
    
    func testEqualStraightIsTie() {
        // TODO: refactor helper function to handle ties
    }
    
    func testStraight_winsOver_threeOfAKind() {
        guard let winningHand = parseHand(hand: "2S 3H 4H 5S 6C"),
              let losingHand = parseHand(hand: "AH AC 5H 6H AS")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .straight)
    }
    
    func test3OfAKind_winsOver_twoPair() {
        guard let losingHand = parseHand(hand: "2S 2H 4H 5S 4C"),
              let winningHand = parseHand(hand: "AH AC 5H 6H AS")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .threeOfAKind)
    }
    
    func testTwoPair_winsOver_pair() {
        guard let winningHand = parseHand(hand: "2S 2H 4H 5S 4C"),
              let losingHand = parseHand(hand: "AH AC 5H 6H 7S")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .twoPair)
    }
    
    // Note, there appears to be an error with this test
    // setup as both hands contain a pair of aces but the
    // notes say "The highest pair wins"
    func testHighPairWins() {
        guard let losingHand = parseHand(hand: "6S AD 7H 4S AS"),
              let winningHand = parseHand(hand: "AH AC 5H 6H 7S")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .pair)
    }
    
    func testPairWins_over_dud() {
        guard let losingHand = parseHand(hand: "2S AH 4H 5S KC"),
              let winningHand = parseHand(hand: "AH AC 5H 6H 7S")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .pair)
    }
    
    func testHighPair_wins() {
        guard let losingHand = parseHand(hand: "8C 4S KH JS 4D"),
              let winningHand = parseHand(hand: "KC 4H KS 2H 8D")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
        testHands(winningHand: winningHand, losingHand: losingHand, expectedHandRank: .pair)
    }
    
    func testHighCard_winsOver_lowCard() {
        guard let winningHand = parseHand(hand: "KD 6S 9D TH AD"),
              let losingHand = parseHand(hand: "JH 8S TH AH QH")
        else {
            XCTFail("invalid hand(s)")
            return
        }
        
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
    
    private func parseHand(hand: String) -> Hand? {
        var cards: [Card] = []
        for cardWithSuit in hand.components(separatedBy: " ") {
            let stringCard = String(cardWithSuit)
            
            guard let valueChar = stringCard.first,
                  let suitChar = stringCard.last,
                  // get rank from Int or Letter
                  let value = Rank(rawValue: Int(String(valueChar)) ?? 0)
                    ?? rank(from: String(valueChar)),
                  
                  let suit = Suit(rawValue: String(suitChar))
            else {
                return nil
            }
            
            cards.append(Card(suit: suit, rank: value))
        }
        
        return Hand(cards: cards)
    }
    
    private func rank(from string: String) -> Rank? {
        switch string {
        case "A":
            return .ace
        case "K":
            return .king
        case "Q":
            return .queen
        case "J":
            return .jack
        case "T":
            return .ten
        default:
            return nil
        }
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
            deck.replaceDeckWithNewDeck()
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
            cards.append(deck.drawCardFromDeckAndRemove())
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
