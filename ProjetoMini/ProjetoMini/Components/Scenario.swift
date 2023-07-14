//
//  Scenario.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 13/07/23.
//

import Foundation
import SpriteKit

// MARK: that is OUR SCENARIO. A parent class that contains all designed platforms

class LayerScenario: SKNode {
    
    func createTileMapColliders(_ tilemap: SKTileMapNode) {
        let tileSize = CGSize(width: tilemap.numberOfColumns, height: tilemap.numberOfRows)
        
        let scaleX = 0.1
        let scaleY = 0.1
        
        // MARK: "for" that add physics to all pixels of the platforms
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
                        square.position = scaledPos
                        square.physicsBody = SKPhysicsBody(rectangleOf: scaledSize)
                        square.physicsBody?.isDynamic = false
                        square.physicsBody?.affectedByGravity = false
                        square.physicsBody?.allowsRotation = false
                        square.name = "platform"
                        square.physicsBody?.categoryBitMask = physicsCategory.platform.rawValue
                        
                        // MARK: add all squares to the class LayerScenario
                        self.addChild(square)
                        
                    }
                }
            }
        }
        
    }

    
    
}
