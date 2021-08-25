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
        // TODO: force-unwrapped
        let highHand1 = player1.hand!.rankHand()
        let highHand2 = player2.hand!.rankHand()
        
        if highHand1.rawValue > highHand2.rawValue {
            return .win(rank: highHand1, player: player1)
            // highHand tied, check for next highest card that doesn't tie
        } else if highHand1.rawValue == highHand2.rawValue {
            
            if player1.hand!.highCard() > player2.hand!.highCard() {
                return .win(rank: highHand1, player: player1)
            } else if player1.hand!.highCard() == player2.hand!.highCard() {
                return .tie
            } else {
                return .win(rank: highHand2, player: player2)
            }
            
        } else {
            return .win(rank: highHand2, player: player2)
        }
    }
}

enum WinningHand {
    case win(rank: WinningHandType, player: Player)
    case tie
}
