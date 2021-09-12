//
//  Deck.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import Foundation

class Deck {
    private var cards: [Card] = []
    
    init() {
        replaceDeckWithNewDeck()
        shuffleDeck()
    }
    
    func drawCardFromDeckAndRemove() -> Card {
        let randomNumber = Int.random(in: 0..<cards.count)
        let card = cards[randomNumber]
        defer { cards.remove(at: randomNumber) } // defer to mutate collection after card is returned
        return card
    }

    func replaceDeckWithNewDeck() {
        cards = Suit.allCases.flatMap { suit in
            Rank.allCases.map { rank in
                Card(suit: suit, rank: rank)
            }
        }
    }
    
    func shuffleDeck() {
        cards.shuffle()
    }
    
    var count: Int {
        cards.count
    }
}
