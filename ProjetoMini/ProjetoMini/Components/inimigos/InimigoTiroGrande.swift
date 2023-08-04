//
//  InimigoTiroGrande.swift
//  ProjetoMini
//
//  Created by Luca Lacerda on 04/08/23.
//

import Foundation
import SpriteKit

class InimigoB: Inimigo{
    
    override func mover() {
        
        //Distancia entre o inimigo e o player
        let dx = distanceX(a: target!.position, b: self.position)
        
        //Verifica se o player está no range de movimento do inimigo
        if dx > CGFloat(self.safeDistance) + 100 && dx < 200 {
            
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
    
    override func attack() {
        //Cria e declara as caracteristicas da bala do inimigo
        let bullet = SKSpriteNode(imageNamed: "enemyBTiro")
        bullet.name = "enemyBullet"
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 9)
        bullet.physicsBody?.categoryBitMask = physicsCategory.enemyBullet.rawValue
        bullet.physicsBody?.collisionBitMask = physicsCategory.none.rawValue
        bullet.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.isDynamic = true
        
        //Variável que controla a variação de tiro
        let shootVariation = CGFloat.random(in: -0.2...0.2)
        
        //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo X
        if self.position.x > 0{
            
            //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo Y
            if self.position.y > 0{
                
                //Cálculos para localizar a posição equivalente a do player dentro do sistema de localização utilizando o inimigo como ponto (X:0, Y:0)
                var dx = (bullet.position.x) - self.position.x
                var dy = (bullet.position.y) - self.position.y
                
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                //Ações realizadas pelo projetil do inimigo, o impulso na direção do player e depois tirar o node da cena.
                let movement = SKAction.run {
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX*2, dy: (velocityY*2) + shootVariation))
                }
                self.addChild(bullet)
                let done = SKAction.removeFromParent()
                bullet.run(.sequence([movement,.wait(forDuration: 300.0),done]))
            }
            
            //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo Y
            if self.position.y < 0 {
                
                //Cálculos para localizar a posição equivalente a do player dentro do sistema de localização utilizando o inimigo como ponto (X:0, Y:0)
                var dx = (bullet.position.x) - self.position.x
                var dy = (bullet.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                //Ações realizadas pelo projetil do inimigo, o impulso na direção do player e depois tirar o node da cena.
                let movement = SKAction.run {
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX*2, dy: (velocityY*2) + shootVariation))
                }
                self.addChild(bullet)
                let done = SKAction.removeFromParent()
                bullet.run(.sequence([movement,.wait(forDuration: 120.0),done]))
            }
        }
        
        //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo X
        if self.position.x < 0{
            
            //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo Y
            if self.position.y > 0 {
                
                //Cálculos para localizar a posição equivalente a do player dentro do sistema de localização utilizando o inimigo como ponto (X:0, Y:0)
                var dx = (bullet.position.x) + self.position.x
                var dy = (bullet.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                //Ações realizadas pelo projetil do inimigo, o impulso na direção do player e depois tirar o node da cena.
                let movement = SKAction.run {
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX*2, dy: (velocityY*2) + shootVariation))
                }
                self.addChild(bullet)
                let done = SKAction.removeFromParent()
                bullet.run(.sequence([movement,.wait(forDuration: 120.0),done]))
            }
            
            //Verifica em qual quadrante do plano da layerScenario o inimigo se localiza em relação ao eixo Y
            if self.position.y < 0 {
                
                //Cálculos para localizar a posição equivalente a do player dentro do sistema de localização utilizando o inimigo como ponto (X:0, Y:0)
                var dx = (bullet.position.x) - self.position.x
                var dy = (bullet.position.y) - self.position.y
                
                dx = dx + target!.position.x
                dy = dy + target!.position.y
                
                let angle = atan2(dy, dx)
                
                let velocityX = cos(angle)
                let velocityY = sin(angle)
                
                //Ações realizadas pelo projetil do inimigo, o impulso na direção do player e depois tirar o node da cena.
                let movement = SKAction.run {
                    bullet.physicsBody?.applyImpulse(CGVector(dx: velocityX*2, dy: (velocityY*2) + shootVariation))
                }
                let done = SKAction.removeFromParent()
                
                self.addChild(bullet)
                bullet.run(.sequence([movement,.wait(forDuration: 120.0),done]))
            }
        }
    }
    
    override func morreu() {
        //Deixa o inimigo invisivel, retira todas as suas ações e após 10 segundos realiza um remove from parent
        self.isAlive = false
        let limpaTexture = SKAction.run {
            self.texture = nil
        }
        self.physicsBody = nil
        self.removeAllActions()
        self.position = CGPoint(x: self.position.x, y: self.position.y + 10)
        self.size.width = 64
        self.size.height = 80
        //Verifica para qual lado o inimigo está olhando para realizar a animação de morte equivalente
        if isLeft{
            self.removeAction(forKey: "animacaoD")
            self.run(.sequence([.animate(with: deSpawnL, timePerFrame: 0.1),limpaTexture,.wait(forDuration: 300),.removeFromParent()]))
        }else{
            self.removeAction(forKey: "animacaoL")
            self.run(.sequence([.animate(with: deSpawnR, timePerFrame: 0.1),limpaTexture,.wait(forDuration: 300),.removeFromParent()]))
        }
    }
}
