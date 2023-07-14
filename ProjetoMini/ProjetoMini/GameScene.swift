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
        layerScenario.addChild(player)
        addChild(jbase)
        addChild(jhandle)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let location = t.location(in: self)
            
            //MARK: Makes the "joystick" appear where the user touched if it`s on the left side of the screen
            if location.x <= (view?.bounds.size.width)! * 0.5{
                jhandle.position = location
                jbase.position = location
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Takes the first touch if there is one
        guard let touch = touches.first else { return }
        // Saves the location of first touch
        let location = touch.location(in: touch.view)
        
        // Checks if is on teh left side of the screen
        if location.x < view!.bounds.size.width * 0.5{
            //the how much you moved the handle
            displacement = location.x - jbase.position.x
            
            // Limit the handle's movement within the defined range
            let displacementLimited = max(-jbase.size.width/2, min(jbase.size.width/2, displacement))
            
            // Update the position of the handle
            jhandle.position = CGPoint(x: jbase.position.x + displacementLimited, y: jbase.position.y)
      
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        displacement = 0 
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if displacement > 0 || displacement < 0{
            player.playerMove(displacement: displacement)
        }
    }
}
