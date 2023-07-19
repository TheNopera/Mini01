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
    case none = 0x0
    case platform = 0x1
    case player = 0x2
    case playerBullet = 0x3
    case enemy = 0x4
    case enemyBullet = 0x5
}

// MARK: Setup screen size
let screenWidth: CGFloat = 852
let screenHeight: CGFloat = 393
