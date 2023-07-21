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
    case none = 0x00000000 // 0
    case platform = 0x00000001 // 1
    case player = 0x00000010 // 2
    case enemy = 0x00000100 // 4
    case playerBullet = 0x00001000 // 8
    case enemyBullet = 0x00010000 // 16
}
