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
        
        let highHand1 = hand1.rankHand()
        let highHand2 = hand2.rankHand()
        
        if highHand1.rawValue > highHand2.rawValue {
            return .win(rank: highHand1, player: player1)
            // highHand tied
        } else if highHand1.rawValue == highHand2.rawValue {
            // check for next highest card that doesn't tie
            if hand1.highCard() > hand2.highCard() {
                return .win(rank: highHand1, player: player1)
            } else if player1.hand!.highCard() == player2.hand!.highCard() {
                var highCard = hand1.highCard()
                
                for i in (0...3).reversed() {
                    if hand1.cards[i] > hand2.cards[i] {
                        highCard = hand1.cards[i]
                    } else if player2.hand!.cards[i] > player1.hand!.cards[i] {
                        highCard = hand2.cards[i]
                    }
                }
                
                if highCard == hand2.highCard() {
                    return .tie
                } else {
                    return highCard > hand1.highCard() ? .win(rank: highHand2, player: player2) : .win(rank: highHand1, player: player1)
                }
            } else {
                return .win(rank: highHand2, player: player2)
            }
        }
        return .tie // edge case
    }
}

enum WinningHand {
    case win(rank: WinningHandType, player: Player)
    case tie
}
