//
//  Player.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 11/07/23.
//

import Foundation
import SpriteKit

class Player:SKSpriteNode{
    
    private(set) var playerSpeed:CGFloat = 0
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: 64, height: 64)
        self.color = .green
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = physicsCategory.player.rawValue
        self.physicsBody?.collisionBitMask = physicsCategory.platform.rawValue
        self.name = "player"
        self.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: PLAYER MOVEMENT FUNCTION
    func playerMove(displacement:Double){
        //let movementDistance = displacement * playerSpeed
        
        //DummyPlayer.physicsBody?.applyImpulse(CGVector(dx: movementDistance, dy: 0))
        self.playerSpeed = displacement > 0 ? 5 : -5
        // Apply the movement to the player's position
        let newPosition = CGPoint(x: self.position.x + self.playerSpeed, y: self.position.y)
     
        self.position = newPosition
    }
    
    //MARK: PLAYER JUMP FUNCTION
    func playerJump(){
        
    }
}
