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
    var SwipeHandler: CustomSwipeHandler!
    var jumps:Int = 0
    var hasContact:Bool = false
    var goDown:Bool = false
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: 64, height: 64)
        self.color = .green
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = physicsCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = physicsCategory.platform.rawValue
        self.physicsBody?.collisionBitMask = physicsCategory.platform.rawValue
        self.physicsBody?.restitution = 0.0
        self.name = "player"
        self.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupSwipeHandler() {
        guard let scene = scene else {
            return // The scene is not set yet, can't initialize the swipe handler
        }
        SwipeHandler = CustomSwipeHandler(scene: scene, player: self)
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
        if jumps < 1{
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120))
            jumps += 1
        }
           
        
        
    }
    
    func playerGodown(){
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -60))
        if self.physicsBody!.velocity.dy == 0{
            goDown = true
        }
        
    }
    
    func handleSwipe(_ direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .right:
            print("dash to the right")
            // Handle right swipe
        case .left:
            print("dash to the left")
            // Handle left swipe
        case .up:
            if self.physicsBody!.velocity.dy == 0{
                self.playerJump()
            }
         
            // Handle up swipe
        case .down:
            self.playerGodown()
            // Handle down swipe
        default:
            break
        }
        
    }
}
