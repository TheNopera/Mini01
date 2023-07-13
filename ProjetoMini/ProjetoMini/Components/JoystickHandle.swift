//
//  JoystickHandle.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 11/07/23.
//

import Foundation
import SpriteKit

var jhandle:SKSpriteNode = {
    var handle =  SKSpriteNode(imageNamed: "Jhandle")
    //makes joystick invisible
    //handle.alpha = 0.0
    handle.size = CGSize(width: 40, height: 40)
    //initial position
    handle.position = CGPoint(x: 100, y: 100)
    handle.zPosition = 2
    

    return handle
}()
