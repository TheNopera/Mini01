//
//  Player.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 11/07/23.
//

import Foundation
import SpriteKit

class Player:SKSpriteNode{
    
    var playerSpeed:CGFloat = 0.05
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
       
        self.size = CGSize(width: 32, height: 32)
        self.color = .green
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = physicsCategory.player.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playerMove(displacement:Double){
        let movementDistance = displacement * playerSpeed
        
        //DummyPlayer.physicsBody?.applyImpulse(CGVector(dx: movementDistance, dy: 0))
        //var speed:CGFloat = displacement > 0 ? 10 : -10
        // Apply the movement to the player's position
        let newPosition = CGPoint(x: self.position.x + movementDistance, y: self.position.y)
     
        self.position = newPosition
    }
}
