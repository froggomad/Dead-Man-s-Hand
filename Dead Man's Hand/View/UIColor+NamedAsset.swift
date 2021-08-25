//
//  UIColor+NamedAsset.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import UIKit


extension UIColor {
    
    /// stores colors in named assets
    enum NamedColor: String {
        case feltColor
        
        var color: UIColor {
            .init(named: rawValue)!
        }
    }
    /// convenient method to pull asset out using enum (avoid magic strings)
    static func namedAsset(_ named: NamedColor) -> UIColor {
        named.color
    }
}
