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
    var vidas:Int = 3
    var SwipeHandler: CustomSwipeHandler!
    var jumps:Int = 0
    var hasContact:Bool = false
    var goDown:Bool = false
    var isDashing:Bool = false
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: 64, height: 64)
        self.color = .green
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = physicsCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = physicsCategory.platform.rawValue | physicsCategory.enemy.rawValue | physicsCategory.enemyBullet.rawValue
        self.physicsBody?.collisionBitMask = physicsCategory.platform.rawValue | physicsCategory.enemy.rawValue | physicsCategory.enemyBullet.rawValue
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
        if self.physicsBody!.velocity.dy == 0{
            goDown = true
        }
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -60))
        
    }
    
    func dash(direction: UISwipeGestureRecognizer.Direction){
        self.isDashing = true
        let imortal = SKAction.run {
            self.physicsBody?.categoryBitMask = physicsCategory.none.rawValue
        }
        let mortal = SKAction.run {
            self.physicsBody?.categoryBitMask = physicsCategory.player.rawValue
        }
        
        if direction == .left{
            let move = SKAction.move(to: CGPoint(x: self.position.x - 180, y: self.position.y) , duration: 0.2)
            
            self.run(.sequence([imortal,move,mortal]))
            
        } else {
            let move = SKAction.move(to: CGPoint(x: self.position.x + 180, y: self.position.y) , duration: 0.2)
            
            self.run(.sequence([imortal,move,mortal]))
        }
        self.isDashing = false
    }
    
    func handleSwipe(_ direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .right:
            dash(direction: .right)
        case .left:
            dash(direction: .left)
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
    
    func tomouDano(){
        self.vidas -= 1
    }
}
