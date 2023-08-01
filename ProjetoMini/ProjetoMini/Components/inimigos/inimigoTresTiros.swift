//
//  inimigoTresTiros.swift
//  ProjetoMini
//
//  Created by Luca Lacerda on 01/08/23.
//

import Foundation
import SpriteKit

class Chaser:Inimigo{
    
    override func mover() {
        let dx = distanceX(a: target!.position, b: self.position)
        
        
        if dx > CGFloat(self.safeDistance) + 100{
            
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
                var dx = (bullet1.position.x) - self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                let movement1 = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                
                let movement2 = SKAction.run {
                    bullet2.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY + 0.3))
                }
                
                let movement3 = SKAction.run {
                    bullet3.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY - 0.3))
                }
                
                self.addChild(bullet1)
                self.addChild(bullet2)
                self.addChild(bullet3)
                let done = SKAction.removeFromParent()
                
                bullet1.run(.sequence([movement1,.wait(forDuration: 10.0),done]))
                bullet2.run(.sequence([.wait(forDuration: 0.05),movement2,.wait(forDuration: 10.0),done]))
                bullet3.run(.sequence([.wait(forDuration: 0.05),movement3,.wait(forDuration: 10.0),done]))
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
                
                let movement1 = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                
                let movement2 = SKAction.run {
                    bullet2.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY + 0.3))
                }
                
                let movement3 = SKAction.run {
                    bullet3.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY - 0.3))
                }
                
                self.addChild(bullet1)
                self.addChild(bullet2)
                self.addChild(bullet3)
                let done = SKAction.removeFromParent()
                
                bullet1.run(.sequence([movement1,.wait(forDuration: 10.0),done]))
                bullet2.run(.sequence([.wait(forDuration: 0.05),movement2,.wait(forDuration: 10.0),done]))
                bullet3.run(.sequence([.wait(forDuration: 0.05),movement3,.wait(forDuration: 10.0),done]))
                
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
                
                let movement1 = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                
                let movement2 = SKAction.run {
                    bullet2.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY + 0.3))
                }
                
                let movement3 = SKAction.run {
                    bullet3.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY - 0.3))
                }
                
                self.addChild(bullet1)
                self.addChild(bullet2)
                self.addChild(bullet3)
                let done = SKAction.removeFromParent()
                
                bullet1.run(.sequence([movement1,.wait(forDuration: 10.0),done]))
                bullet2.run(.sequence([.wait(forDuration: 0.05),movement2,.wait(forDuration: 10.0),done]))
                bullet3.run(.sequence([.wait(forDuration: 0.05),movement3,.wait(forDuration: 10.0),done]))
                
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
                
                let movement1 = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
                }
                
                let movement2 = SKAction.run {
                    bullet2.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY + 0.3))
                }
                
                let movement3 = SKAction.run {
                    bullet3.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY - 0.2))
                }
                
                self.addChild(bullet1)
                self.addChild(bullet2)
                self.addChild(bullet3)
                let done = SKAction.removeFromParent()
                
                bullet1.run(.sequence([movement1,.wait(forDuration: 10.0),done]))
                bullet2.run(.sequence([.wait(forDuration: 0.05),movement2,.wait(forDuration: 10.0),done]))
                bullet3.run(.sequence([.wait(forDuration: 0.05),movement3,.wait(forDuration: 10.0),done]))
                
            }
        }
    }
}
