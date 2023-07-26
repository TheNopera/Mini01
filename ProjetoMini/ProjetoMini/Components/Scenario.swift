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
    
    var spawnPoint1: SKSpriteNode!
    var spawnPoint2: SKSpriteNode!
    var spawnPoint3: SKSpriteNode!
    var inimigosAR: [Inimigo] = []
    var spawnPoints: [SKSpriteNode] = []
    
    override init() {
        super.init()
        spawnPoint1 = SKSpriteNode()
             spawnPoint1.name = "spawnPoint1" // precisa do nome para conseguir coloca-los na scene
        spawnPoint1.position = CGPoint(x: frame.midX + 200, y: frame.minY)
             addChild(spawnPoint1)
        spawnPoint2 = SKSpriteNode()
             spawnPoint2.name = "spawnPoint2" // precisa do nome para conseguir coloca-los na scene
        spawnPoint2.position = CGPoint(x: frame.midX - 200, y: frame.minY)
             addChild(spawnPoint2)
        spawnPoint3 = SKSpriteNode()
             spawnPoint3.name = "spawnPoint3" // precisa do nome para conseguir coloca-los na scene
        spawnPoint3.position = CGPoint(x: frame.midX, y: frame.minY)
             addChild(spawnPoint3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                        
                        let square = SKSpriteNode(texture: SKTexture(imageNamed: "platform-centertile"))
                        square.position = tilePos
                        square.physicsBody = SKPhysicsBody(rectangleOf: textureSize)
                        square.physicsBody?.isDynamic = false
                        square.physicsBody?.affectedByGravity = false
                        square.physicsBody?.restitution = 0.0
                        square.physicsBody?.allowsRotation = false
                        square.physicsBody?.usesPreciseCollisionDetection = true
                        square.name = "platform"
                        square.zPosition = 20.0
                        square.physicsBody?.categoryBitMask = physicsCategory.platform.rawValue
                        square.physicsBody?.collisionBitMask = physicsCategory.player.rawValue
                        square.physicsBody?.contactTestBitMask = physicsCategory.player.rawValue
                        
                        // MARK: add all squares to the class LayerScenario
                        self.addChild(square)
                        
                    }
                }
            }
        }
        
    }
    func InimigoSpawn1(target: Player){
        enumerateChildNodes(withName: "spawnPoint1"){ node, _ in
            if let spawnPoint = node as? SKSpriteNode{
                let inimigo = Inimigo()
                inimigo.position = spawnPoint.position
                self.addChild(inimigo)
                inimigo.zPosition = 20.0
                self.inimigosAR.append(inimigo)
                inimigo.target = target
            }
            
        }
    }
    func InimigoSpawn2(target: Player){
        enumerateChildNodes(withName: "spawnPoint2"){ node, _ in
            if let spawnPoint = node as? SKSpriteNode{
                let inimigo = Inimigo()
                inimigo.position = spawnPoint.position
                self.addChild(inimigo)
                inimigo.zPosition = 20.0
                self.inimigosAR.append(inimigo)
                inimigo.target = target
            }
            
        }
    }
    func InimigoSpawn3(target: Player){
        enumerateChildNodes(withName: "spawnPoint3"){ node, _ in
            if let spawnPoint = node as? SKSpriteNode{
                let inimigo = Inimigo()
                inimigo.position = spawnPoint.position
                self.addChild(inimigo)
                inimigo.zPosition = 20.0
                self.inimigosAR.append(inimigo)
                inimigo.target = target
            }
            
        }
    }
}
