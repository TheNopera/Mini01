//
//  Gameplay.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 11/07/23.
//

import Foundation
import SpriteKit

//MARK: Physics categories go here, call this enum to set categories.
enum physicsCategory:UInt32{
    case player = 0x1
    case platform
    case enemy
}
