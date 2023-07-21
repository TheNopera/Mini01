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
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size.height = 64
        self.size.width = 64
        self.color = .red
        name = "enemy"
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
        
        self.run(.repeatForever(.sequence([ataque,SKAction.wait(forDuration: 1.0)])))
    }
    
    convenience init (target: SKSpriteNode){
        let tex = SKTexture(imageNamed: "inimigo")
        self.init(texture:tex, color: UIColor.white, size: tex.size())
        self.target = target
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attack(){
        let bullet = SKShapeNode(circleOfRadius: 6)
        bullet.name = "enemyBullet"
        bullet.fillColor = SKColor(ciColor: .red)
        
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
                
                self.addChild(bullet)
                let done = SKAction.removeFromParent()
                bullet.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
        }
    }
}
