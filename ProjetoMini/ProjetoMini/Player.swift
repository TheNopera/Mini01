//
//  Player.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 11/07/23.
//

import Foundation
import SpriteKit

var player:SKSpriteNode = {
    var Player = SKSpriteNode()
    Player.color = .green
    Player.size = CGSize(width: 32, height: 32)
    Player.position = CGPoint(x: 300, y: 100)
    Player.physicsBody?.categoryBitMask = physicsCategory.player.rawValue
    return Player
}()

func movePlayer(displacement:Double){
    let playerSpeed: CGFloat = 0.05 // Adjust the player's speed as needed
    
    // Calculate the desired movement distance based on the displacement and player's speed
    let movementDistance = displacement * playerSpeed
    
    //DummyPlayer.physicsBody?.applyImpulse(CGVector(dx: movementDistance, dy: 0))
    //var speed:CGFloat = displacement > 0 ? 10 : -10
    // Apply the movement to the player's position
    let newPosition = CGPoint(x: player.position.x + movementDistance, y: player.position.y)
 
    player.position = newPosition
    
}


