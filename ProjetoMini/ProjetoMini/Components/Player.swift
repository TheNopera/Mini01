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
    var vidas = 3
    var SwipeHandler: CustomSwipeHandler!
    var jumps:Int = 0
    var hasContact:Bool = false
    var goDown:Bool = false
    var isTurningLeft:Bool = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = physicsCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = physicsCategory.platform.rawValue | physicsCategory.enemy.rawValue | physicsCategory.enemyBullet.rawValue
        self.physicsBody?.collisionBitMask = physicsCategory.platform.rawValue | physicsCategory.enemy.rawValue | physicsCategory.enemyBullet.rawValue
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody?.restitution = 0.0
        self.name = "player"
        self.physicsBody?.allowsRotation = false
        
        let atirar = SKAction.run {
            self.atirando()
        }
        
        self.run(.repeatForever(.sequence([atirar,.wait(forDuration: 1.0)])))
    }
    
    convenience init (){
        let tex = SKTexture(imageNamed: "Player")
        self.init(texture:tex, color: UIColor.white, size: tex.size())
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
    
    func tomouDano(){
        self.vidas -= 1
    }
    
    func atirando(){
        
        let bullet = SKShapeNode(circleOfRadius: 6)
        bullet.fillColor = SKColor(ciColor: .red)
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.allowsRotation = false
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask = physicsCategory.playerBullet.rawValue
        bullet.physicsBody?.contactTestBitMask = physicsCategory.enemy.rawValue
        bullet.physicsBody?.collisionBitMask = physicsCategory.enemy.rawValue
        bullet.physicsBody?.restitution = 0.0
        
        if self.isTurningLeft{
        
            bullet.position.x = bullet.position.x - self.size.width/2 + 15
            let mover = SKAction.run {
                bullet.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0))
            }
            let done = SKAction.removeFromParent()
          
            self.addChild(bullet)
            bullet.run(.sequence([mover,.wait(forDuration: 10.0),done]))
        } else{
            
            bullet.position.x = bullet.position.x + self.size.width/2 + 15
            let mover = SKAction.run {
                bullet.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 0))
            }
            let done = SKAction.removeFromParent()
            
            self.addChild(bullet)
            bullet.run(.sequence([mover,.wait(forDuration: 10.0),done]))
        }
    }
}
