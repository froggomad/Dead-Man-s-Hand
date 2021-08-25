//
//  Player.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import Foundation

class Player { // reference type due to time constraints (easier to update hands without using delegation and/or perfecting the architecture)
    let name: String
    var hand: Hand?
    
    init(name: String) {
        self.name = name
    }

}
