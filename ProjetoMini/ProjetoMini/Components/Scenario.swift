//
//  Scenario.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 13/07/23.
//

import Foundation
import SpriteKit

// MARK: parent class that contains all platforms
class Scenario: SKNode {
    

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
                            
                            let square = SKShapeNode(rectOf: scaledSize)
                            square.strokeColor = UIColor.white.withAlphaComponent(0)
                            square.position = scaledPos
//                            square.physicsBody = SKPhysicsBody(rectangleOf: scaledSize)
                            square.physicsBody?.isDynamic = false
                            square.physicsBody?.affectedByGravity = false
                            square.physicsBody?.allowsRotation = false
                            square.name = "Chao"
                            square.physicsBody?.categoryBitMask = 2
                            self.addChild(square)
                            
                        }
                    }
                }
            }

        }

    
    
}
