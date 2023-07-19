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
    var joystick:Joystick = Joystick()
    let cameraPlayer = SKCameraNode()
    var displacement:Double = 0
    
    //MARK: file that contains all designed platforms
    let tileMapScenario: SKScene = SKScene(fileNamed: "ScenarioTileMap")!
    
    // MARK: instance of class LayerScenario
    let layerScenario = LayerScenario()

    
    override func didMove(to view: SKView) {
        
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

    }
    
    
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
       print("contato começou ")
        let contactMask = contact.bodyA.categoryBitMask + contact.bodyB.categoryBitMask
       //print("contactMask: \(contactMask)")
        let plataformaNormal = physicsCategory.player.rawValue + physicsCategory.platform.rawValue
 
        
        if contactMask == plataformaNormal{ // Player and platform collision

            player.hasContact = true
            player.jumps = 0
        }
            
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("contato terminou ")
        let contactMask = contact.bodyA.categoryBitMask + contact.bodyB.categoryBitMask
        
        if contactMask == physicsCategory.player.rawValue + physicsCategory.platform.rawValue {// Player and platform collision
            if player.physicsBody!.velocity.dy != 0{
                player.goDown = false
                player.hasContact = false
            }


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

    }
    
    
}
