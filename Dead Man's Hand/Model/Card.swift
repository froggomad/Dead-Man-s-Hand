//
//  CardParts.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import UIKit

enum Suit: String, CaseIterable {
    case spades = "S", hearts = "H", diamonds = "D", clubs = "C"
}

enum Rank: Int, CustomStringConvertible, Comparable, CaseIterable {
    
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    case ace
    
    var description: String {
        switch self {
        case .ace:
            return "A"
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        default:
            return "\(self.rawValue)"
        }
    }
    
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func == (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
}

struct Card: Equatable {
    let suit: Suit
    let rank: Rank
    lazy var color: UIColor = {
        switch suit {
        case .clubs, .spades:
            return .black
        case .hearts, .diamonds:
            return .red
        }
    }()
    
    static func ==(_ lhs: Card, _ rhs: Card) -> Bool {
        lhs.rank == rhs.rank
    }
    
    static func >(_ lhs: Card, _ rhs: Card) -> Bool {
        lhs.rank > rhs.rank
    }
}
