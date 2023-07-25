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
    var tempoAtual:Int?
    var limiteInimigos:Int{
        if let tempo = self.tempoAtual{
            if tempo < 30{
                return 4
            } else if tempo > 30 && tempo < 60{
                return 6
            } else if tempo > 90 {
                return 8
            }
        }
        return 3
    }
    
    override init() {
        super.init()
        
        spawnPoint1 = SKSpriteNode()
        spawnPoint1.name = "spawnPoint1" // precisa do nome para conseguir coloca-los na scene
        spawnPoint1.position = CGPoint(x: frame.midX + 200, y: frame.minY)
        spawnPoints.append(spawnPoint1)
        addChild(spawnPoint1)
        
        spawnPoint2 = SKSpriteNode()
        spawnPoint2.name = "spawnPoint2" // precisa do nome para conseguir coloca-los na scene
        spawnPoint2.position = CGPoint(x: frame.midX - 200, y: frame.minY)
        spawnPoints.append(spawnPoint2)
        addChild(spawnPoint2)
        
        spawnPoint3 = SKSpriteNode()
        spawnPoint3.name = "spawnPoint3" // precisa do nome para conseguir coloca-los na scene
        spawnPoint3.position = CGPoint(x: frame.midX, y: frame.minY)
        spawnPoints.append(spawnPoint3)
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
                        
                        let square = SKSpriteNode(color: .white, size: scaledSize)
                        square.position = scaledPos
                        square.physicsBody = SKPhysicsBody(rectangleOf: scaledSize)
                        square.physicsBody?.isDynamic = false
                        square.physicsBody?.affectedByGravity = false
                        square.physicsBody?.restitution = 0.0
                        square.physicsBody?.allowsRotation = false
                        square.physicsBody?.usesPreciseCollisionDetection = true
                        square.name = "platform"
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
                
                if self.inimigosAR.count < self.limiteInimigos{
                    
                    let verificaPos = self.verificaPosição(spawnNum: 1)
                  
                    if verificaPos{
                        
                        let inimigo = Shooter()
                        inimigo.numSpawn = 1
                        inimigo.position = spawnPoint.position
                        self.addChild(inimigo)
                        self.inimigosAR.append(inimigo)
                        inimigo.target = target
                    }
                }
            }
            
        }
    }
    func InimigoSpawn2(target: Player){
        enumerateChildNodes(withName: "spawnPoint2"){ node, _ in
            if let spawnPoint = node as? SKSpriteNode{
                
                if self.inimigosAR.count < self.limiteInimigos{
                    
                    let verificaPos = self.verificaPosição(spawnNum: 2)
                  
                    if verificaPos{
                        
                        let inimigo = Chaser()
                        inimigo.numSpawn = 2
                        inimigo.position = spawnPoint.position
                        self.addChild(inimigo)
                        
                        self.inimigosAR.append(inimigo)
                        inimigo.target = target
                    }
                }
            }
            
        }
    }
    func InimigoSpawn3(target: Player){
        enumerateChildNodes(withName: "spawnPoint3"){ node, _ in
            if let spawnPoint = node as? SKSpriteNode{
                
                if self.inimigosAR.count < self.limiteInimigos{
                    
                    let verificaPos = self.verificaPosição(spawnNum: 3)
                  
                    if verificaPos{
                        
                        let inimigo = Inimigo()
                        inimigo.numSpawn = 3
                        inimigo.position = spawnPoint.position
                        self.addChild(inimigo)
                        
                        self.inimigosAR.append(inimigo)
                        inimigo.target = target
                    }
                }
            }
        }
    }
    
    func verificaPosição(spawnNum:Int) -> Bool{
        
        for inimigo in self.inimigosAR {
            let dx = distanceX(a: inimigo.position, b: spawnPoints[spawnNum-1].position)
            if dx < 50{
                return false
            }
        }
        return true
    }
    
    
}
