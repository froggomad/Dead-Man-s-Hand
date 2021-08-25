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
        sort()
    }
    
    mutating func sort() {
        cards.sort(by: { $0.rank < $1.rank })
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
