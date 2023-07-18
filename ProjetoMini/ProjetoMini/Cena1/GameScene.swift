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
    
    // MARK: instance of class HUDNode
    let hudNode = HUDNode()
    
    override func didMove(to view: SKView) {
        
        // MARK: add physics to the world
        self.physicsWorld.contactDelegate = self
        
            // MARK: verify if tileMapScenario has a SKTileMapNode child
        if let tilemapNode = tileMapScenario.childNode(withName: "TileMapNode") as? SKTileMapNode {
            
            layerScenario.createTileMapColliders(tilemapNode)
            hudNode.setupGameOver()
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
        cameraPlayer.addChild(hudNode)
        hudNode.position = CGPoint(x: -852*0.5, y: -393*0.5)



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
        print("Touch ended")
        for t in touches{
            if t == joystick.jPosition{
                joystick.setDisplacement(value: 0)
                print("Touch ended2")
            }
        }
     
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch cancelled1")
        for t in touches{
            if t == joystick.jPosition {
                print("Touch cancelled2")
                joystick.setDisplacement(value: 0)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
       // print("contato começou ")
        let contactMask = contact.bodyA.categoryBitMask + contact.bodyB.categoryBitMask
       // print("contactMask: \(contactMask)")
        let plataformaNormal = physicsCategory.player.rawValue + physicsCategory.platform.rawValue
 
        
        if contactMask == plataformaNormal{ // Player and platform collision
//            goDown = false
            if !player.hasContact{
                player.hasContact = true
            }
        }
        
            
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        //print("contato terminou ")
        let contactMask = contact.bodyA.categoryBitMask + contact.bodyB.categoryBitMask
        
        if contactMask == physicsCategory.player.rawValue | physicsCategory.platform.rawValue { // Player and platform collision
            if player.hasContact{
                player.hasContact = false
            }
        
        }
       // print(hasContact)
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        if joystick.displacement != 0{
            player.playerMove(displacement: joystick.displacement)
        }
        cameraPlayer.position = player.position
    }
}


// MARK: - GameOver
extension GameScene {
    
    private func gameOver() {
        //player morre
        hudNode.setupGameOver()
    }
}
