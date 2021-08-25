//
//  CardGame.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import Foundation

protocol CardGame {
    var deck: Deck { get }
    var player1: Player { get }
    var player2: Player { get }
    var ranker: HandRanker { get }
    func playHands()
}
