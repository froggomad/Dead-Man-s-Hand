//
//  HandRanker.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import Foundation
// TODO: Move logic from hand to here
struct HandRanker {
    let player1: Player
    let player2: Player
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    func highHand() -> WinningHand {
        guard let hand1 = player1.hand,
              let hand2 = player2.hand
        else { return .tie }
        
        let highHand1 = rankHand(hand1)
        let highHand2 = rankHand(hand2)
        
        if highHand1.rawValue > highHand2.rawValue {
            return .win(rank: highHand1, player: player1)
            // highHand tied
        } else if highHand1.rawValue == highHand2.rawValue {
            // check for next highest card that doesn't tie
            if highestCard(hand1) > highestCard(hand2) {
                return .win(rank: highHand1, player: player1)
            } else if highestCard(hand1) == highestCard(hand2) {
                var highCard = highestCard(hand1)
                
                for i in (0...3).reversed() {
                    if hand1.cards[i] > hand2.cards[i] {
                        highCard = hand1.cards[i]
                    } else if player2.hand!.cards[i] > player1.hand!.cards[i] {
                        highCard = hand2.cards[i]
                    }
                }
                
                if highCard == highestCard(hand2) {
                    return .tie
                } else {
                    return highCard > highestCard(hand1) ? .win(rank: highHand2, player: player2) : .win(rank: highHand1, player: player1)
                }
            } else {
                return .win(rank: highHand2, player: player2)
            }
        } else if highHand2.rawValue > highHand1.rawValue {
            return .win(rank: highHand2, player: player2)
        }
        
        return .tie // edge case
    }
    
    /// Rank a player's Hand
    func rankHand(_ hand: Hand) -> WinningHandType {
        if isFlush(hand) {
            if isStraight(hand) {
                return .straightFlush
            }
            return .flush
        } else if isStraight(hand) {
            return .straight
        } else {
            // this is performed last even though some hands rank
            // higher than straight and flush. Due to a straight or
            // flush ruling out any possibilities this method produces
            return findRankMatches(hand)
        }
        
    }
    /// Returns the highest ranking winning hand out of the player's hand
    ///
    /// Possibilities:
    /// - high card
    /// - pair
    /// - two pair
    /// - 3 of a kind
    /// - full house
    /// - four of a kind
    private func findRankMatches(_ hand: Hand) -> WinningHandType {
        let tupleArray = hand.cards.map { ($0.rank, 1) }
        
        let rankFrequencyMap = Dictionary(tupleArray, uniquingKeysWith: +)
        let max = rankFrequencyMap.max(by: { $0.value < $1.value })?.value
        
        guard let max = max else { return .highCard }
        
        switch max {
        case 4:
            return .fourOfAKind
        case 3:
            if rankFrequencyMap.contains(where: {$0.value == 2}) {
                return .fullHouse
            }
            return .threeOfAKind
        case 2:
            for (key, value) in rankFrequencyMap {
                if value == 2 {
                    for (secondKey, value) in rankFrequencyMap {
                        if value == 2 && key != secondKey {
                            return .twoPair
                        }
                    }
                }
            }
            return .pair
        default:
            return .highCard
        }
    }
    
    private func isFlush(_ hand: Hand) -> Bool {
        let suits = hand.cards.map({$0.suit})
        return suits.allSatisfy({ $0 == suits.first })
    }
    
    private func isStraight(_ hand: Hand) -> Bool {
        let ranks = hand.cards.map { $0.rank }
        var lastRank = ranks[0].rawValue
        var consecutiveCards = 1
        
        for (i, rank) in ranks.enumerated() {
            if i != 0 { // lastRank contains first element
                if rank.rawValue == lastRank + 1 {
                    consecutiveCards += 1
                } else {
                    break // exit early since this isn't a straight
                }
            }
            lastRank = rank.rawValue
        }
        
        return consecutiveCards == 5
    }
    
    func highestCard(_ hand: Hand) -> Card {
        let max = hand.cards.max(by: { $0.rank.rawValue < $1.rank.rawValue})!
        return max
    }
    
}

enum WinningHand {
    case win(rank: WinningHandType, player: Player)
    case tie
}
