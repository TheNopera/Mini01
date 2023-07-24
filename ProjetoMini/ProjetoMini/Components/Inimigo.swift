//
//  Inimigo.swift
//  ProjetoMini
//
//  Created by Luca Lacerda on 17/07/23.
//


import SpriteKit

class Inimigo:SKSpriteNode{
    var target: SKSpriteNode?
    var isShotting: Bool = false
    var vidas = 3
    var ID:UUID = UUID()
    var animationD = [
        SKTexture(imageNamed: "inimigoD1"),
        SKTexture(imageNamed: "inimigoD2")
    ]
    var velocity = Int.random(in: 2...4)
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        name = ID.uuidString
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = physicsCategory.enemy.rawValue
        physicsBody?.contactTestBitMask = physicsCategory.player.rawValue | physicsCategory.playerBullet.rawValue
        physicsBody?.collisionBitMask = physicsCategory.platform.rawValue | physicsCategory.player.rawValue | physicsCategory.playerBullet.rawValue
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = true
        physicsBody?.isDynamic = true
        physicsBody?.restitution = 0.0
        
        let ataque = SKAction.run {
            self.attack()
        }
        let mover = SKAction.run {
            self.mover()
        }
        self.run(.repeatForever(.sequence([mover,.wait(forDuration: 0.1)])), withKey: "vivo1")
        self.run(.repeatForever(.sequence([ataque,SKAction.wait(forDuration: 1.0)])),withKey: "vivo2")
        self.run(.repeatForever(.animate(with: animationD, timePerFrame: 0.5)),withKey: "animacaoD")
    }
    
    convenience init (){
        let tex = SKTexture(imageNamed: "inimigoD1")
        self.init(texture:tex, color: UIColor.clear, size: tex.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func inimigoTomouDano(){
        self.vidas -= 1
    }
    func attack(){
        let bullet = SKSpriteNode(imageNamed: "enemytiro")
        bullet.name = "enemyBullet"
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bullet.physicsBody?.categoryBitMask = physicsCategory.enemyBullet.rawValue
        bullet.physicsBody?.collisionBitMask = physicsCategory.none.rawValue
        bullet.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.isDynamic = true
        
        if self.position.x > 0{
            
            if self.position.y > 0{
                var dx = (bullet.position.x) + self.position.x
                var dy = (bullet.position.y) - self.position.y
                
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement = SKAction.run {
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                
                self.addChild(bullet)
                let done = SKAction.removeFromParent()
                bullet.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
            //Caso funciona
            if self.position.y < 0 {
                
                var dx = (bullet.position.x) - self.position.x
                var dy = (bullet.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement = SKAction.run {
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                self.addChild(bullet)
                let done = SKAction.removeFromParent()
                bullet.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
        }
        
        if self.position.x < 0{
            //Caso funciona
            if self.position.y > 0 {
                
                var dx = (bullet.position.x) + self.position.x
                var dy = (bullet.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement = SKAction.run {
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                
                self.addChild(bullet)
                let done = SKAction.removeFromParent()
                bullet.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
            //caso funciona
            if self.position.y < 0 {
                
                var dx = (bullet.position.x) - self.position.x
                var dy = (bullet.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement = SKAction.run {
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                let done = SKAction.removeFromParent()
                
                self.addChild(bullet)
                bullet.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
        }
    }
    
    func mover(){
        
        let dx = distanceX(a: target!.position, b: self.position)
        
        
        if dx > 240 && dx < 500 {
            
            if target!.position.x < self.position.x{
                self.position.x -= self.speed
            }
            
            if target!.position.x > self.position.x{
                self.position.x += self.speed
            }
            
        } else if dx < 240 {
            
            if target!.position.x < self.position.x{
                self.position.x += self.speed
            }
            
            if target!.position.x > self.position.x{
                self.position.x -= self.speed
            }
        }
    }
    
    func morreu(){
        self.texture = nil
        self.physicsBody = nil
        self.removeAction(forKey: "vivo1")
        self.removeAction(forKey: "vivo2")
        self.removeAction(forKey: "animacaoD")
        
        
        self.run(.sequence([.wait(forDuration: 10),.removeFromParent()]))
    }
}
