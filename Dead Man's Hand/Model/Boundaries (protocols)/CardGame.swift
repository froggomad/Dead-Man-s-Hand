//
//  CardGame.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import Foundation

protocol CardGame {
    var deck: Deck { get }
    var ranker: HandRanker { get }
    func playHands() -> WinningHand
}
