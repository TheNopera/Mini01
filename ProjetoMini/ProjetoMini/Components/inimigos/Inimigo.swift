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
    var animation =  [
        SKTexture(imageNamed: "inimigoL1"),
        SKTexture(imageNamed: "inimigoL2"),
        SKTexture(imageNamed: "inimigoL3"),
        SKTexture(imageNamed: "inimigoL4"),
        SKTexture(imageNamed: "inimigoL5")
    ]
    var deSpawnL = [
        SKTexture(imageNamed: "spawnL9"),
        SKTexture(imageNamed: "spawnL8"),
        SKTexture(imageNamed: "spawnL7"),
        SKTexture(imageNamed: "spawnL6"),
        SKTexture(imageNamed: "spawnL5"),
        SKTexture(imageNamed: "spawnL4"),
        SKTexture(imageNamed: "spawnL3"),
        SKTexture(imageNamed: "spawnL2"),
        SKTexture(imageNamed: "spawnL1"),
    ]
    var deSpawnR = [
        SKTexture(imageNamed: "spawnD9"),
        SKTexture(imageNamed: "spawnD8"),
        SKTexture(imageNamed: "spawnD7"),
        SKTexture(imageNamed: "spawnD6"),
        SKTexture(imageNamed: "spawnD5"),
        SKTexture(imageNamed: "spawnD4"),
        SKTexture(imageNamed: "spawnD3"),
        SKTexture(imageNamed: "spawnD2"),
        SKTexture(imageNamed: "spawnD1"),
    ]
    var velocity = Int.random(in: 4...8)
    var safeDistance = Int.random(in: 180...240)
    var isAlive = true
    var isLeft:Bool{
        if let target = self.target{
            if target.position.x < self.position.x{
                return true
            }else{
                return false
            }
        } else {
            return true
        }
    }
    var lookingLeft:Bool?
    var numSpawn:Int?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        name = ID.uuidString
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = physicsCategory.enemy.rawValue
        physicsBody?.contactTestBitMask = physicsCategory.player.rawValue | physicsCategory.playerBullet.rawValue
        physicsBody?.collisionBitMask = physicsCategory.platform.rawValue |  physicsCategory.playerBullet.rawValue | physicsCategory.nofallplatform.rawValue
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
        self.run(.repeatForever(.sequence([.wait(forDuration: 0.5),ataque,SKAction.wait(forDuration: shootOcurrance)])),withKey: "vivo2")
    }
    
    convenience init (){
        
        let tex = SKTexture(imageNamed: "inimigoD1")
        
        self.init(texture:tex, color: UIColor.clear, size: tex.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inimigoTomouDano(){
        let opacDown = SKAction.run {
            self.alpha = 0.5
        }
        let opacityUp = SKAction.run {
            self.alpha = 1
        }
        
        let bulletopacity = SKAction.run {
            self.enumerateChildNodes(withName: "enemyBullet"){ node, _ in
                if let bullet = node as? SKSpriteNode{
                    bullet.alpha = 1
                }
            }
        }
        
        self.vidas -= 1
        self.run(.repeat(bulletopacity, count: 5))
        self.run(.group([opacDown,.wait(forDuration: 0.2),opacityUp]))
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
        
        
        if dx > CGFloat(self.safeDistance) + 100 && dx < 450 {
            
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
        self.position = CGPoint(x: self.position.x, y: self.position.y + 10)
        self.size.width = 64
        self.size.height = 80
        if isLeft{
            self.removeAction(forKey: "animacaoD")
            self.run(.sequence([.animate(with: deSpawnL, timePerFrame: 0.1),limpaTexture,.wait(forDuration: 10),.removeFromParent()]))
        }else{
            self.removeAction(forKey: "animacaoL")
            self.run(.sequence([.animate(with: deSpawnR, timePerFrame: 0.1),limpaTexture,.wait(forDuration: 10),.removeFromParent()]))
        }
    }
    
    func verificaTargetPosition(){
        if isAlive{
            if target!.position.x > self.position.x && !self.isLeft{
                self.animation = [
                    SKTexture(imageNamed: "inimigoL1"),
                    SKTexture(imageNamed: "inimigoL2"),
                    SKTexture(imageNamed: "inimigoL3"),
                    SKTexture(imageNamed: "inimigoL4"),
                    SKTexture(imageNamed: "inimigoL5")
                ]
                if self.action(forKey: "animacaoL") == nil{
                    self.removeAction(forKey: "animacaoD")
                    self.run(.repeatForever(.animate(with: animation, timePerFrame: 0.2)),withKey: "animacaoL")
                }
            } else if target!.position.x < self.position.x && self.isLeft{
                self.animation = [
                    SKTexture(imageNamed: "inimigoD1"),
                    SKTexture(imageNamed: "inimigoD2"),
                    SKTexture(imageNamed: "inimigoD3"),
                    SKTexture(imageNamed: "inimigoD4"),
                    SKTexture(imageNamed: "inimigoD5")
                ]
                if self.action(forKey: "animacaoD") == nil{
                    self.removeAction(forKey: "animacaoL")
                    self.run(.repeatForever(.animate(with: animation, timePerFrame: 0.2)),withKey: "animacaoD")
                }
            }
        }
    }
}
