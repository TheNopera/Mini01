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
    var isJumping:Bool = false
    var isImortal = false
    let moveRightAnimation:[SKTexture] = [
        SKTexture(imageNamed: "player_move 1"),
        SKTexture(imageNamed: "player_move 2"),
        SKTexture(imageNamed: "player_move 3"),
        SKTexture(imageNamed: "player_move 4"),
        SKTexture(imageNamed: "player_move 5")
    ]
    let moveLeftAnimation:[SKTexture] = [
        SKTexture(imageNamed: "player_moveE 1"),
        SKTexture(imageNamed: "player_moveE 2"),
        SKTexture(imageNamed: "player_moveE 3"),
        SKTexture(imageNamed: "player_moveE 4"),
        SKTexture(imageNamed: "player_moveE 5")
    ]
    let jumpRightAnimation: [SKTexture] = [
        SKTexture(imageNamed: "player_jump 1"),
        SKTexture(imageNamed: "player_jump 2"),
        SKTexture(imageNamed: "player_jump 3"),
        SKTexture(imageNamed: "player_jump 4"),
        SKTexture(imageNamed: "player_jump 5"),
        SKTexture(imageNamed: "player_jump 6"),
        SKTexture(imageNamed: "player_jump 7"),
        SKTexture(imageNamed: "player_jump 8")
        
    ]
    let jumpLeftAnimation: [SKTexture] = [
        SKTexture(imageNamed: "player_jumpE 1"),
        SKTexture(imageNamed: "player_jumpE 2"),
        SKTexture(imageNamed: "player_jumpE 3"),
        SKTexture(imageNamed: "player_jumpE 4"),
        SKTexture(imageNamed: "player_jumpE 5"),
        SKTexture(imageNamed: "player_jumpE 6"),
        SKTexture(imageNamed: "player_jumpE 7"),
        SKTexture(imageNamed: "player_jumpE 8")
        
    ]
    let deathAnimationR: [SKTexture] = [
        SKTexture(imageNamed: "player_death 2"),
        SKTexture(imageNamed: "player_death 3"),
        SKTexture(imageNamed: "player_death 4"),
        SKTexture(imageNamed: "player_death 5"),
        SKTexture(imageNamed: "player_death 6"),
        SKTexture(imageNamed: "player_death 7"),
        SKTexture(imageNamed: "player_death 8")
    ]
    let deathAnimationL: [SKTexture] = [
        SKTexture(imageNamed: "player_deathE 2"),
        SKTexture(imageNamed: "player_deathE 3"),
        SKTexture(imageNamed: "player_deathE 4"),
        SKTexture(imageNamed: "player_deathE 5"),
        SKTexture(imageNamed: "player_deathE 6"),
        SKTexture(imageNamed: "player_deathE 7"),
        SKTexture(imageNamed: "player_deathE 8")
    ]
    let idleAnimationR:[SKTexture] = [SKTexture(imageNamed: "Player")]
    let idleAnimationL:[SKTexture] = [SKTexture(imageNamed: "PlayerE")]
    
    
    
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width/2, height: self.size.height))
        self.physicsBody?.categoryBitMask = physicsCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = physicsCategory.platform.rawValue | physicsCategory.nofallplatform.rawValue | physicsCategory.enemy.rawValue | physicsCategory.enemyBullet.rawValue
        self.physicsBody?.collisionBitMask = physicsCategory.platform.rawValue | physicsCategory.enemy.rawValue | physicsCategory.enemyBullet.rawValue
        self.physicsBody?.restitution = 0.0
        self.name = "player"
        self.physicsBody?.allowsRotation = false
        
        let atirar = SKAction.run {
            self.atirando()
        }
        
        self.run(.repeatForever(.sequence([atirar,.wait(forDuration: 0.6)])))
    }
    
    convenience init (){
        let tex = SKTexture(imageNamed: "inimigoD1")
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
        if self.vidas > 0{
            let newPosition = CGPoint(x: self.position.x + self.playerSpeed, y: self.position.y)
            self.position = newPosition
        }
        if self.playerSpeed == 5 {
            enumerateChildNodes(withName: "leftBullet"){ node, _ in
                let bullet = node as? SKSpriteNode
                bullet!.position = CGPoint(x: bullet!.position.x - self.playerSpeed, y: bullet!.position.y)
            }
        }
        if self.playerSpeed == -5{
            enumerateChildNodes(withName: "rightBullet"){ node, _ in
                let bullet = node as? SKSpriteNode
                bullet!.position = CGPoint(x: bullet!.position.x - self.playerSpeed, y: bullet!.position.y)
            }
        }
    }
    
    //MARK: PLAYER JUMP FUNCTION
    func playerJump(){
        if jumps < 1{
            if self.vidas > 0{
                self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
                jumps += 1
                isJumping = true
            }
        }
    }
    
    func playerGodown(){
        if self.vidas > 0{
            if self.physicsBody!.velocity.dy == 0{
                goDown = true
                self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -30))
            }
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
    
    func tomouTiro(){
        if !isImortal{
            
        }
        self.tomouDano()
    }
    
    func tomouDano(){
        if self.vidas > 0{
            let imortal = SKAction.run {
                self.isImortal = true
            }
            let mortal = SKAction.run {
                self.isImortal = false
            }
            let opacDown = SKAction.run {
                self.alpha = 0.5
            }
            let opacityUp = SKAction.run {
                self.alpha = 1
            }
            
            if !isImortal{
                self.vidas -= 1
                self.run(.repeat(.sequence([opacDown,.wait(forDuration: 0.2),opacityUp,.wait(forDuration: 0.2)]), count: 4))
                self.run(.sequence([imortal,.wait(forDuration: 1.5),mortal]))
            }
        }
        
    }
    func encostouNoInimigo(direção:Double){
        let impulse = direção > 0 ? -25 : 25
        if !self.isImortal{
            self.physicsBody?.applyImpulse(CGVector(dx: impulse, dy: 10))
            self.tomouDano()
        }
        
    }
    
    func atirando(){
        
        let bullet = SKSpriteNode(imageNamed: "playertiro")
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.allowsRotation = false
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask = physicsCategory.playerBullet.rawValue
        bullet.physicsBody?.contactTestBitMask = physicsCategory.enemy.rawValue
        bullet.physicsBody?.collisionBitMask = physicsCategory.enemy.rawValue
        bullet.physicsBody?.restitution = 0.0
        
        let audioNode = SKAudioNode(fileNamed: "Player_Gunshot4.mp3")
        //audioNode.autoplayLooped = false
        stopAudioAfterDuration(audioNode: audioNode, duration: 1)
        //audioNode.gain = 0.8
        
        if self.isTurningLeft{
            bullet.name = "leftBullet"
            bullet.position.x = bullet.position.x - self.size.width/2 + 15
            let mover = SKAction.run {
                bullet.physicsBody?.applyImpulse(CGVector(dx: -3, dy: 0))
            }
            let done = SKAction.removeFromParent()
            
            self.addChild(bullet)
            bullet.run(.sequence([mover,.wait(forDuration: 10.0),done]))
            self.addChild(audioNode)
        
        } else{
            bullet.name = "rightBullet"
            bullet.position.x = bullet.position.x + self.size.width/2 - 15
            let mover = SKAction.run {
                bullet.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
            }
            let done = SKAction.removeFromParent()
            
            self.addChild(bullet)
            bullet.run(.sequence([mover,.wait(forDuration: 10.0),done]))
            self.addChild(audioNode)
        }
    }
    func stopAudioAfterDuration(audioNode: SKAudioNode, duration: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            audioNode.run(SKAction.stop()) // Pausa o áudio após o tempo especificado
        }
    }
}
