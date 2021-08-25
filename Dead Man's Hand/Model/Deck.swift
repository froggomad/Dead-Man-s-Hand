//
//  Deck.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import Foundation

struct Deck {
    private var cards: [Card] = []
    
    init() {
        refresh()
        shuffle()
    }
    
    /// Draw a card from the deck
    /// - Note: Card will be removed from `cards`
    /// after operation completes
    mutating func drawCard() -> Card {
        let randomNumber = Int.random(in: 0..<cards.count)
        let card = cards[randomNumber]
        defer { cards.remove(at: randomNumber) } // defer to mutate collection after card is returned
        return card
    }
    
    /// Fill the deck with cards
    /// - WARNING: Will replace `cards` collection in place
    mutating func refresh() {
        cards = Suit.allCases.flatMap { suit in
            Rank.allCases.map { rank in
                Card(suit: suit, rank: rank)
            }
        }
    }
    
    /// Shuffle the deck 7 times
    mutating func shuffle() {
        // vegas shuffles 7 times :P
        (1...7).forEach { _ in
            cards.shuffle()
        }
    }
    
    var count: Int {
        cards.count
    }
}
