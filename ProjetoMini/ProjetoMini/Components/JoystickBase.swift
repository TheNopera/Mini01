//
//  Joystick.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 11/07/23.
//

import Foundation
import SpriteKit

var jbase:SKSpriteNode = {
    var base =  SKSpriteNode(imageNamed: "Jbase")
    //makes joystick invisible
    //base.alpha = 0.0
    base.size = CGSize(width: 100, height: 100)
    //initial position
    base.position = CGPoint(x: 100, y: 100)
    base.zPosition = 2
    return base
}()

