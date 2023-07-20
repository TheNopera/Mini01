//
//  GameScene.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 06/07/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:Player = Player()
    //var inimigo:Inimigo = Inimigo()
    var joystick:Joystick = Joystick()
    let cameraPlayer = SKCameraNode()
    var displacement:Double = 0
    
    //MARK: file that contains all designed platforms
    let tileMapScenario: SKScene = SKScene(fileNamed: "ScenarioTileMap")!
    
    // MARK: instance of class LayerScenario
    let layerScenario = LayerScenario()
    
    
    override func didMove(to view: SKView) {
        print("teste")
        
        // MARK: add physics to the world
        self.physicsWorld.contactDelegate = self
        
        // MARK: verify if tileMapScenario has a SKTileMapNode child
        if let tilemapNode = tileMapScenario.childNode(withName: "TileMapNode") as? SKTileMapNode {
            
            layerScenario.createTileMapColliders(tilemapNode)
        }
        
        // MARK: center the scenario position in GameScene
        layerScenario.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        self.addChild(layerScenario)
        layerScenario.addChild(cameraPlayer)
        layerScenario.addChild(player)
        
        player.setupSwipeHandler()
        
        self.camera = cameraPlayer
        cameraPlayer.addChild(joystick)
        joystick.position = CGPoint(x: 0, y: 0)
        
        layerScenario.InimigoSpawn(target: player)
        
        /*for xp in(0...4){
         for yp in(0...10){
         let inimigo = Inimigo()
         inimigo.position.x = CGFloat(frame.midX)
         inimigo.position.y = CGFloat(frame.midX)
         inimigo.target = player
         layerScenario.addChild(inimigo)
         }
         
         }*/
    }
    
    func addEnemiesFromTileMap(){ }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let location = t.location(in: cameraPlayer)
            
            //MARK: Makes the "joystick" appear where the user touched if it`s on the left side of the screen
            if location.x < 0 {
                joystick.moveJoystickToTouch(newPosition: location)
                joystick.jPosition = t
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Takes the first touch if there is one
        guard let touch = touches.first else { return }
        // Saves the location of first touch
        let location = touch.location(in: cameraPlayer)
        
        // Checks if is on teh left side of the screen
        if location.x < 0{
            joystick.calculateDisplacement(touchLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            if t == joystick.jPosition{
                joystick.setDisplacement(value: 0)
            }
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            if t == joystick.jPosition {
                joystick.setDisplacement(value: 0)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask + contact.bodyB.categoryBitMask
        
        switch contactMask{
        case physicsCategory.player.rawValue + physicsCategory.platform.rawValue: // player e plataforma
            player.hasContact = true
            player.jumps = 0
            
        case  physicsCategory.player.rawValue + physicsCategory.enemyBullet.rawValue: // player e disparo inimigo
            
            if contact.bodyA.node?.name == "player"{
                _ = contact.bodyA.node
                let enemyBullet = contact.bodyB.node
                
                enemyBullet!.removeFromParent()
                player.tomouDano()
                print(player.vidas)
                if player.vidas == 0{
                    
                }
                
            } else{
                _ = contact.bodyB.node
                let enemyBullet = contact.bodyA.node
                
                enemyBullet!.removeFromParent()
                player.tomouDano()
                if player.vidas == 0{
                    
                }
                print(player.vidas)
            }
            
        case physicsCategory.enemy.rawValue + physicsCategory.playerBullet.rawValue: // inimigo e disparo do player
            print("player acertou o inimigo")
            
        case physicsCategory.player.rawValue + physicsCategory.enemy.rawValue: // player e inimigo
            print("inimigo e player se encostaram")
            
        case physicsCategory.enemy.rawValue + physicsCategory.enemyBullet.rawValue:
            print("bala bateu no inimigo")
            
        default: // contato não corresponde a nenhum caso
            print("no functional contact")
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask + contact.bodyB.categoryBitMask
        
        switch contactMask{
        case physicsCategory.player.rawValue + physicsCategory.platform.rawValue:// Player and platform collision
            if player.physicsBody!.velocity.dy != 0{
                player.goDown = false
                player.hasContact = false
            }
        default:
            print("no functional end contact")
        }
    }
    override func update(_ currentTime: TimeInterval) {
        if joystick.displacement != 0{
            player.playerMove(displacement: joystick.displacement)
        }
        cameraPlayer.position = player.position
        
        if player.physicsBody?.velocity.dy != 0 && player.hasContact == false{
            player.jumps = 1
        }
        
        if let body = player.physicsBody {
            let dy = body.velocity.dy
            //            print(dy)
            if dy > 0 {
                // Prevent collisions if the hero is jumping
                body.collisionBitMask = physicsCategory.player.rawValue
                //print("\((body.collisionBitMask))")
                
            } else if dy < 0  && player.goDown{
                body.collisionBitMask = physicsCategory.player.rawValue
            }
            else {
                // Allow collisions if the hero is falling
                body.collisionBitMask |= physicsCategory.platform.rawValue
                // print("\((body.collisionBitMask))")
                
            }
        }
        if layerScenario.inimigosAR != nil{
            for enemies in layerScenario.inimigosAR{
                attack(inimigo: enemies)
            }
        }
    }
//MARK: teste
    func attack(inimigo: SKSpriteNode){
        let bullet = SKShapeNode(circleOfRadius: 12)
        bullet.position = inimigo.position
        bullet.name = "enemyBullet"
        bullet.fillColor = SKColor(ciColor: .red)
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bullet.physicsBody?.categoryBitMask = physicsCategory.enemyBullet.rawValue
        bullet.physicsBody?.collisionBitMask = physicsCategory.none.rawValue
        bullet.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.restitution = 0.0
        
        let variantion = CGFloat.random(in: 1...10)
        let variantDirection = 1 // Int.random(in: 1...2)
        
        if variantDirection == 1{
            
            
            let offset = CGPoint(x: player.position.x, y: player.position.y + variantion) - bullet.position
            let direction = offset.normalized()
            let shootAmount = direction * 1000
            let realDest = shootAmount + bullet.position
            
            let mover = SKAction.move(to: realDest, duration: 2)
            let done = SKAction.removeFromParent()
            
            inimigo.addChild(bullet)
            bullet.run(.sequence([mover,done]))
            
        } else{
            let offset = CGPoint(x: player.position.x, y: player.position.y - variantion) - bullet.position
            let direction = offset.normalized()
            let shootAmount = direction * 1000
            let realDest = shootAmount + bullet.position
            
            let mover = SKAction.move(to: realDest, duration: 2)
            let done = SKAction.removeFromParent()
            
            self.addChild(bullet)
            bullet.run(.sequence([mover,done]))
        }
    }
    
}


