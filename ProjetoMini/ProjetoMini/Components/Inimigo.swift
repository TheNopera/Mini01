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
        
        self.size.width = 32
        self.size.height = 36
        self.color = .red
        
        name = "enemy"
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = physicsCategory.enemy.rawValue
        physicsBody?.contactTestBitMask = physicsCategory.player.rawValue | physicsCategory.playerBullet.rawValue
        physicsBody?.collisionBitMask = physicsCategory.platform.rawValue | physicsCategory.player.rawValue | physicsCategory.playerBullet.rawValue
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = true
        physicsBody?.isDynamic = true
        let ataque = SKAction.run {
            self.attack()
        }
        self.run(.repeatForever(.sequence([ataque,SKAction.wait(forDuration: 2.0)])))
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
        let bullet = SKShapeNode(circleOfRadius: 2)
        bullet.name = "enemyBullet"
        bullet.fillColor = SKColor(ciColor: .red)
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 2)
        bullet.physicsBody?.categoryBitMask = physicsCategory.enemyBullet.rawValue
        bullet.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
        bullet.physicsBody?.collisionBitMask = physicsCategory.player.rawValue
        bullet.physicsBody?.isDynamic = false
        bullet.physicsBody?.affectedByGravity = false
        
        let variantion = CGFloat.random(in: 1...10)
        let variantDirection = Int.random(in: 1...2)
        
        if variantDirection == 1{
            let offset = CGPoint(x: target!.position.x, y: target!.position.y + variantion) - bullet.position
            let direction = offset.normalized()
            let shootAmount = direction * 1000
            let realDest = shootAmount + bullet.position
            
            let mover = SKAction.move(to: realDest, duration: 2)
            let done = SKAction.removeFromParent()
            
            self.addChild(bullet)
            print("\(self.position), \(bullet.position)")
            bullet.run(.sequence([mover,done]))
            
        } else{
            let offset = CGPoint(x: target!.position.x, y: target!.position.y - variantion) - bullet.position
            let direction = offset.normalized()
            let shootAmount = direction * 1000
            let realDest = shootAmount + bullet.position
            
            let mover = SKAction.move(to: realDest, duration: 2)
            let done = SKAction.removeFromParent()
            
            self.addChild(bullet)
            print("\(self.position), \(bullet.position)")
            bullet.run(.sequence([mover,done]))
        }
    }
}
