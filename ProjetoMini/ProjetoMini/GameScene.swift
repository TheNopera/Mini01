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
    let scenario: SKScene = SKScene(fileNamed: "ScenarioTileMap")!
    let camada: SKNode = SKNode()

    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        if let tilemapNode = scenario.childNode(withName: "TileMapNode") as? SKTileMapNode {
            
            createTileMapColliders(tilemapNode)
        }


        camada.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        self.addChild(camada)
//        camada.addChild(scenario)
        camada.addChild(player)
        addChild(jbase)
        addChild(jhandle)
        
        
        //MARK: Use to test the movement of the player while theres no platform
//        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
    }
    
    func createTileMapColliders(_ tilemap: SKTileMapNode) {
        let tileSize = CGSize(width: tilemap.numberOfColumns, height: tilemap.numberOfRows)
        
        let scaleX = 0.1
        let scaleY = 0.1
        
        for y in 0..<Int(tileSize.height) {
            for x in 0..<Int(tileSize.width) {
                let definition = tilemap.tileDefinition(atColumn: x, row: y)
                let textures = definition?.textures
                let tilePos = tilemap.centerOfTile(atColumn: x, row: y)
                
                if let textures = textures {
                    for texture in textures {
                        let textureSize = texture.size()
                        let scaledSize = CGSize(width: textureSize.width * scaleX, height: textureSize.height * scaleY)
                        let scaledPos = CGPoint(x: tilePos.x * scaleX, y: tilePos.y * scaleY)
                        
                        let square = SKSpriteNode(color: .white, size: scaledSize)
//                        square.strokeColor = UIColor.white.withAlphaComponent(0)
                        square.position = scaledPos
                        square.physicsBody = SKPhysicsBody(rectangleOf: scaledSize)
                        square.physicsBody?.isDynamic = false
                        square.physicsBody?.affectedByGravity = false
                        square.physicsBody?.allowsRotation = false
                        square.name = "Chao"
                        square.physicsBody?.categoryBitMask = 2
                        camada.addChild(square)
                        
                    }
                }
            }
        }
        
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
