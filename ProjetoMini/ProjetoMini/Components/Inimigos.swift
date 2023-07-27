//
//  Inimigo.swift
//  ProjetoMini
//
//  Created by Luca Lacerda on 17/07/23.
//


import SpriteKit

class Inimigo:SKSpriteNode{
    var target: SKSpriteNode?
    var isShotting: Bool?
    var vidas = 2
    var ID:UUID = UUID()
    var animation = [
        SKTexture(imageNamed: "inimigoD1"),
        SKTexture(imageNamed: "inimigoD2"),
        SKTexture(imageNamed: "inimigoD3"),
        SKTexture(imageNamed: "inimigoD4"),
        SKTexture(imageNamed: "inimigoD5")
    ]
    var deSpawn = [
        SKTexture(imageNamed: "spawn9"),
        SKTexture(imageNamed: "spawn8"),
        SKTexture(imageNamed: "spawn7"),
        SKTexture(imageNamed: "spawn6"),
        SKTexture(imageNamed: "spawn5"),
        SKTexture(imageNamed: "spawn4"),
        SKTexture(imageNamed: "spawn3"),
        SKTexture(imageNamed: "spawn2"),
        SKTexture(imageNamed: "spawn1"),
    ]
    var velocity = Int.random(in: 4...8)
    var safeDistance = Int.random(in: 180...240)
    var isAlive = true
    var isLeft:Bool = true
    var numSpawn:Int?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        name = ID.uuidString
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = physicsCategory.enemy.rawValue
        physicsBody?.contactTestBitMask = physicsCategory.player.rawValue | physicsCategory.playerBullet.rawValue
        physicsBody?.collisionBitMask = physicsCategory.platform.rawValue |  physicsCategory.playerBullet.rawValue
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
        
        let shootOcurrance = Double.random(in: 1.5...2.0)
        
        self.run(.repeatForever(.sequence([mover,.wait(forDuration: 0.1)])), withKey: "vivo1")
        self.run(.repeatForever(.sequence([ataque,SKAction.wait(forDuration: shootOcurrance)])),withKey: "vivo2")
        self.run(.repeatForever(.animate(with: animation, timePerFrame: 0.2)),withKey: "animacao")
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
        let bullet = SKSpriteNode(imageNamed: "enemyTiro")
        bullet.name = "enemyBullet"
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bullet.physicsBody?.categoryBitMask = physicsCategory.enemyBullet.rawValue
        bullet.physicsBody?.collisionBitMask = physicsCategory.none.rawValue
        bullet.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.isDynamic = true
        
        let shootVariation = CGFloat.random(in: -0.2...0.2)
        
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
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY + shootVariation))
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
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY + shootVariation))
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
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY + shootVariation))
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
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY + shootVariation))
                }
                let done = SKAction.removeFromParent()
                
                self.addChild(bullet)
                bullet.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
        }
    }
    
    func mover(){
        
        let dx = distanceX(a: target!.position, b: self.position)
        
        
        if dx > CGFloat(self.safeDistance) + 100 && dx < 500 {
            
            if target!.position.x < self.position.x{
                self.position.x -= CGFloat(self.velocity)
            }
            
            if target!.position.x > self.position.x{
                self.position.x += CGFloat(self.velocity)
            }
            
        } else if dx < CGFloat(self.safeDistance){
            
            if target!.position.x < self.position.x{
                self.position.x += CGFloat(self.velocity)
            }
            
            if target!.position.x > self.position.x{
                self.position.x -= CGFloat(self.velocity)
            }
        }
    }
    
    func morreu(){
        self.isAlive = false
        let limpaTexture = SKAction.run {
            self.texture = nil
        }
        self.physicsBody = nil
        self.removeAllActions()
        self.texture = SKTexture(imageNamed: "spawn1")
        self.position = CGPoint(x: self.position.x, y: self.position.y + 10)
        self.size = self.texture!.size()
        self.run(.sequence([.animate(with: deSpawn, timePerFrame: 0.1),limpaTexture,.wait(forDuration: 10),.removeFromParent()]))
    }
    
    func verificaTargetPosition(){
        if isAlive{
            if target!.position.x > self.position.x{
                self.animation = [
                    SKTexture(imageNamed: "inimigoL1"),
                    SKTexture(imageNamed: "inimigoL2"),
                    SKTexture(imageNamed: "inimigoL3"),
                    SKTexture(imageNamed: "inimigoL4"),
                    SKTexture(imageNamed: "inimigoL5")
                ]
                self.removeAction(forKey: "animacao")
                self.run(.repeatForever(.animate(with: animation, timePerFrame: 0.5)),withKey: "animacao")
            } else if target!.position.x < self.position.x {
                self.isLeft = false
                self.animation = [
                    SKTexture(imageNamed: "inimigoD1"),
                    SKTexture(imageNamed: "inimigoD2"),
                    SKTexture(imageNamed: "inimigoD3"),
                    SKTexture(imageNamed: "inimigoD4"),
                    SKTexture(imageNamed: "inimigoD5")
                ]
                self.removeAction(forKey: "animacao")
                self.run(.repeatForever(.animate(with: animation, timePerFrame: 0.5)),withKey: "animacao")
            }
        }
    }
}

class Chaser:Inimigo{
    
    override func attack() {
        let bullet1 = SKSpriteNode(imageNamed: "enemyTiro")
        bullet1.name = "enemyBullet"
        
        bullet1.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bullet1.physicsBody?.categoryBitMask = physicsCategory.enemyBullet.rawValue
        bullet1.physicsBody?.collisionBitMask = physicsCategory.none.rawValue
        bullet1.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
        bullet1.physicsBody?.affectedByGravity = false
        bullet1.physicsBody?.isDynamic = true
        
        let bullet2 = SKSpriteNode(imageNamed: "enemyTiro")
        bullet2.name = "enemyBullet"
        
        bullet2.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bullet2.physicsBody?.categoryBitMask = physicsCategory.enemyBullet.rawValue
        bullet2.physicsBody?.collisionBitMask = physicsCategory.none.rawValue
        bullet2.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
        bullet2.physicsBody?.affectedByGravity = false
        bullet2.physicsBody?.isDynamic = true
        
        let bullet3 = SKSpriteNode(imageNamed: "enemyTiro")
        bullet3.name = "enemyBullet"
        
        bullet3.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bullet3.physicsBody?.categoryBitMask = physicsCategory.enemyBullet.rawValue
        bullet3.physicsBody?.collisionBitMask = physicsCategory.none.rawValue
        bullet3.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
        bullet3.physicsBody?.affectedByGravity = false
        bullet3.physicsBody?.isDynamic = true
        
        if self.position.x > 0{
            
            if self.position.y > 0{
                var dx = (bullet1.position.x) + self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                
                self.addChild(bullet1)
                let done = SKAction.removeFromParent()
                bullet1.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
            //Caso funciona
            if self.position.y < 0 {
                
                var dx = (bullet1.position.x) - self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                self.addChild(bullet1)
                let done = SKAction.removeFromParent()
                bullet1.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
        }
        
        if self.position.x < 0{
            //Caso funciona
            if self.position.y > 0 {
                
                var dx = (bullet1.position.x) + self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                
                self.addChild(bullet1)
                let done = SKAction.removeFromParent()
                bullet1.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
            //caso funciona
            if self.position.y < 0 {
                
                var dx = (bullet1.position.x) - self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                let done = SKAction.removeFromParent()
                
                self.addChild(bullet1)
                bullet1.run(.sequence([movement,.wait(forDuration: 10.0),done]))
            }
        }
    }
}
