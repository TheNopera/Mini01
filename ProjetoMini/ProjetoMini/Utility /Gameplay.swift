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
    case nofallplatform = 0x00100000 // 32
}

// MARK: Setup screen size
let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height

extension String{
    func localizaed() -> String{
        return NSLocalizedString(self,tableName: "Localizable",bundle: .main,value: self, comment: self)
    }
}
