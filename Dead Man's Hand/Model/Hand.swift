//
//  Hand.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import Foundation

struct Hand {
    
    /// The player's cards
    /// - Note: Should Clamp this to have a maximum of 5 cards, but that's cumbersome in Swift
    var cards: [Card]
    
    /// - Parameter cards: count must be 5 or initializer will fail
    init?(cards: [Card]) {
        guard cards.count == 5 else { return nil }
        self.cards = cards
    }
    
    /// Rank a player's Hand
    /// - Returns: <#description#>
    func rankHand() -> WinningHandType {
        if isFlush() {
            if isStraight() {
                return .straightFlush
            }
            return .flush
        } else if isStraight() {
            return .straight
        } else {
            // this is performed last even though some hands rank
            // higher than straight and flush. Due to a straight or
            // flush ruling out any possibilities this method produces
            return findRankMatches()
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
    private func findRankMatches() -> WinningHandType {
        let tupleArray = cards.map { ($0.rank, 1) }
        
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
    
    private func isFlush() -> Bool {
        let suits = cards.map({$0.suit})
        return suits.allSatisfy({ $0 == suits.first })
    }
    
    private func isStraight() -> Bool {
        let ranks = cards.map { $0.rank }
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
    
    func highCard() -> Card {
        let max = cards.max(by: { $0.rank.rawValue < $1.rank.rawValue})!
        return max
    }
}

extension Hand: Equatable {
    
}

// MARK: - Winning Hand -
/// Lists and ranks winning hands
enum WinningHandType: Int {
    case highCard
    case pair
    case twoPair
    case threeOfAKind
    case straight
    case flush
    case fullHouse
    case fourOfAKind
    case straightFlush
    
    var description: String {
        switch self {
        case .highCard:
            return "High Card"
        case .pair:
            return "Pair"
        case .twoPair:
            return "Two Pairs"
        case .threeOfAKind:
            return "Three of a Kind"
        case .straight:
            return "Straight"
        case .flush:
            return "Flush"
        case .fullHouse:
            return "Full House"
        case .fourOfAKind:
            return "Four of a Kind"
        case .straightFlush:
            return "Straight Flush"
        }
    }
}
