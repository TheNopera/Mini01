//
//  inimigoTresTiros.swift
//  ProjetoMini
//
//  Created by Luca Lacerda on 01/08/23.
//

import Foundation
import SpriteKit

//Classe do segundo inimigo, ela herda do primeiro
class Chaser:Inimigo{
    
    //Ovverride da função mover, muda a distancia segura e velocidade do inimigo
    override func mover() {
        //Distancia entre o inimigo e o player
        let dx = distanceX(a: target!.position, b: self.position)
        
        if dx > CGFloat(self.safeDistance) + 100{
            //Move o inimigo de acordo com a posição do inimigo em relação ao player
            if target!.position.x < self.position.x{
                self.position.x -= CGFloat(self.velocity)
                
                enumerateChildNodes(withName: "enemyBullet"){ node, _ in
                    let bullet = node as? SKSpriteNode
                    bullet!.position = CGPoint(x: bullet!.position.x + CGFloat(self.velocity), y: bullet!.position.y)
                }
            }
            
            if target!.position.x > self.position.x{
                self.position.x += CGFloat(self.velocity)
                
                enumerateChildNodes(withName: "enemyBullet"){ node, _ in
                    let bullet = node as? SKSpriteNode
                    bullet!.position = CGPoint(x: bullet!.position.x - CGFloat(self.velocity), y: bullet!.position.y)
                }

            }
            
        } else if dx < CGFloat(self.safeDistance){
            
            if target!.position.x < self.position.x{
                self.position.x += CGFloat(self.velocity)
                
                enumerateChildNodes(withName: "enemyBullet"){ node, _ in
                    let bullet = node as? SKSpriteNode
                    bullet!.position = CGPoint(x: bullet!.position.x - CGFloat(self.velocity), y: bullet!.position.y)
                }
            }
            
            if target!.position.x > self.position.x{
                self.position.x -= CGFloat(self.velocity)
                
                enumerateChildNodes(withName: "enemyBullet"){ node, _ in
                    let bullet = node as? SKSpriteNode
                    bullet!.position = CGPoint(x: bullet!.position.x + CGFloat(self.velocity), y: bullet!.position.y)
                }
            }
        }
    }
    
    //Funcão de ataque do segundo inimigo, ele atira tres tiros nessa função
    override func attack() {
        
        //Cria e declara as caracteristicas das balas do inimigo
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
        
        //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo X
        if self.position.x > 0{
            
            //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo Y
            if self.position.y > 0{
                var dx = (bullet1.position.x) - self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle1 = atan2(dy, dx)
                let velocityX1 = cos(angle1)
                let velocityY1 = sin(angle1)
                
                var angle2 = atan2(dy, dx)
                angle2 += 0.5
                let velocityX2 = cos(angle2)
                let velocityY2 = sin(angle2)
                
                var angle3 = atan2(dy, dx)
                angle3 -= 0.5
                let velocityX3 = cos(angle3)
                let velocityY3 = sin(angle3)

                
                let movement1 = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX1, dy: velocityY1))
                }
                
                let movement2 = SKAction.run {
                    bullet2.physicsBody?.applyImpulse(CGVector(dx: velocityX2, dy: velocityY2))
                }
                
                let movement3 = SKAction.run {
                    bullet3.physicsBody?.applyImpulse(CGVector(dx: velocityX3, dy: velocityY3))
                }
                
                self.addChild(bullet1)
                self.addChild(bullet2)
                self.addChild(bullet3)
                let done = SKAction.removeFromParent()
                
                bullet1.run(.sequence([movement1,.wait(forDuration: 10.0),done]))
                bullet2.run(.sequence([.wait(forDuration: 0.05),movement2,.wait(forDuration: 10.0),done]))
                bullet3.run(.sequence([.wait(forDuration: 0.05),movement3,.wait(forDuration: 10.0),done]))
            }
            
            //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo Y
            if self.position.y < 0 {
                
                var dx = (bullet1.position.x) - self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle1 = atan2(dy, dx)
                let velocityX1 = cos(angle1)
                let velocityY1 = sin(angle1)
                
                var angle2 = atan2(dy, dx)
                angle2 += 0.5
                let velocityX2 = cos(angle2)
                let velocityY2 = sin(angle2)
                
                var angle3 = atan2(dy, dx)
                angle3 -= 0.5
                let velocityX3 = cos(angle3)
                let velocityY3 = sin(angle3)

                
                let movement1 = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX1, dy: velocityY1))
                }
                
                let movement2 = SKAction.run {
                    bullet2.physicsBody?.applyImpulse(CGVector(dx: velocityX2, dy: velocityY2))
                }
                
                let movement3 = SKAction.run {
                    bullet3.physicsBody?.applyImpulse(CGVector(dx: velocityX3, dy: velocityY3))
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
        
        //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo X
        if self.position.x < 0{
            
            //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo Y
            if self.position.y > 0 {
                
                var dx = (bullet1.position.x) + self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle1 = atan2(dy, dx)
                let velocityX1 = cos(angle1)
                let velocityY1 = sin(angle1)
                
                var angle2 = atan2(dy, dx)
                angle2 += 0.5
                let velocityX2 = cos(angle2)
                let velocityY2 = sin(angle2)
                
                var angle3 = atan2(dy, dx)
                angle3 -= 0.5
                let velocityX3 = cos(angle3)
                let velocityY3 = sin(angle3)

                
                let movement1 = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX1, dy: velocityY1))
                }
                
                let movement2 = SKAction.run {
                    bullet2.physicsBody?.applyImpulse(CGVector(dx: velocityX2, dy: velocityY2))
                }
                
                let movement3 = SKAction.run {
                    bullet3.physicsBody?.applyImpulse(CGVector(dx: velocityX3, dy: velocityY3))
                }
                
                self.addChild(bullet1)
                self.addChild(bullet2)
                self.addChild(bullet3)
                let done = SKAction.removeFromParent()
                
                bullet1.run(.sequence([movement1,.wait(forDuration: 10.0),done]))
                bullet2.run(.sequence([.wait(forDuration: 0.05),movement2,.wait(forDuration: 10.0),done]))
                bullet3.run(.sequence([.wait(forDuration: 0.05),movement3,.wait(forDuration: 10.0),done]))
                
            }
            
            //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo Y
            if self.position.y < 0 {
                
                var dx = (bullet1.position.x) - self.position.x
                var dy = (bullet1.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle1 = atan2(dy, dx)
                let velocityX1 = cos(angle1)
                let velocityY1 = sin(angle1)
                
                var angle2 = atan2(dy, dx)
                angle2 += 0.5
                let velocityX2 = cos(angle2)
                let velocityY2 = sin(angle2)
                
                var angle3 = atan2(dy, dx)
                angle3 -= 0.5
                let velocityX3 = cos(angle3)
                let velocityY3 = sin(angle3)

                
                let movement1 = SKAction.run {
                    bullet1.physicsBody?.applyImpulse(CGVector(dx: velocityX1, dy: velocityY1))
                }
                
                let movement2 = SKAction.run {
                    bullet2.physicsBody?.applyImpulse(CGVector(dx: velocityX2, dy: velocityY2))
                }
                
                let movement3 = SKAction.run {
                    bullet3.physicsBody?.applyImpulse(CGVector(dx: velocityX3, dy: velocityY3))
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
