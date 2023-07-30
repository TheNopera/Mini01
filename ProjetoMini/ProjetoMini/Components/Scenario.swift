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
    
    var gameScene: GameScene?
    var spawnPoint1: SKSpriteNode = SKSpriteNode()
    var spawnPoint2: SKSpriteNode = SKSpriteNode()
    var spawnPoint3: SKSpriteNode =  SKSpriteNode()
    var spawnPoint4: SKSpriteNode = SKSpriteNode()
    var spawnPoint5: SKSpriteNode = SKSpriteNode()
    var inimigosAR: [Inimigo] = []
    var hasChaser:Bool = false
    var spawnPoints: [SKSpriteNode] = []
    var tempoAtual:Int?
    var limiteInimigos:Int{
        if let tempo = self.tempoAtual{
            if tempo < 30{
                //return 4
                return 2
            } else if tempo > 30 && tempo < 60{
                //return 6
                return 3
            } else if tempo > 90 {
                //return 8
                return 4
            }
        }
        return 3
    }
    var spawnR = [
        SKTexture(imageNamed: "spawnD1"),
        SKTexture(imageNamed: "spawnD2"),
        SKTexture(imageNamed: "spawnD3"),
        SKTexture(imageNamed: "spawnD4"),
        SKTexture(imageNamed: "spawnD5"),
        SKTexture(imageNamed: "spawnD6"),
        SKTexture(imageNamed: "spawnD7"),
        SKTexture(imageNamed: "spawnD8"),
        SKTexture(imageNamed: "spawnD9"),
    ]
    var spawnL = [
        SKTexture(imageNamed: "spawnL1"),
        SKTexture(imageNamed: "spawnL2"),
        SKTexture(imageNamed: "spawnL3"),
        SKTexture(imageNamed: "spawnL4"),
        SKTexture(imageNamed: "spawnL5"),
        SKTexture(imageNamed: "spawnL6"),
        SKTexture(imageNamed: "spawnL7"),
        SKTexture(imageNamed: "spawnL8"),
        SKTexture(imageNamed: "spawnL9"),
    ]
    override init() {
        super.init()
        
        spawnPoint1.size = CGSize(width: 64, height: 80)
        spawnPoint1.name = "spawnPoint1" // precisa do nome para conseguir coloca-los na scene
        spawnPoint1.zPosition = 21.0
        spawnPoint1.position = CGPoint(x: frame.midX + 200, y: frame.minY)
        spawnPoints.append(spawnPoint1)
        addChild(spawnPoint1)
        
        spawnPoint2.size = CGSize(width: 64, height: 80)
        spawnPoint2.name = "spawnPoint2" // precisa do nome para conseguir coloca-los na scene
        spawnPoint2.zPosition = 21.0
        spawnPoint2.position = CGPoint(x: frame.midX - 200, y: frame.minY)
        spawnPoints.append(spawnPoint2)
        addChild(spawnPoint2)
        
        spawnPoint3.size = CGSize(width: 64, height: 80)
        spawnPoint3.name = "spawnPoint3" // precisa do nome para conseguir coloca-los na scene
        spawnPoint3.zPosition = 21.0
        spawnPoint3.position = CGPoint(x: frame.midX, y: frame.minY + 160)
        spawnPoints.append(spawnPoint3)
        addChild(spawnPoint3)
        
        spawnPoint4.size = CGSize(width: 64, height: 80)
        spawnPoint4.name = "spawnPoint4" // precisa do nome para conseguir coloca-los na scene
        spawnPoint4.zPosition = 21.0
        spawnPoint4.position = CGPoint(x: frame.midX + 480, y: frame.minY + 200)
        spawnPoints.append(spawnPoint4)
        addChild(spawnPoint4)
        
        spawnPoint5.size = CGSize(width: 64, height: 80)
        spawnPoint5.name = "spawnPoint5" // precisa do nome para conseguir coloca-los na scene
        spawnPoint5.zPosition = 21.0
        spawnPoint5.position = CGPoint(x: frame.midX - 320, y: frame.minY - 160)
        spawnPoints.append(spawnPoint5)
        addChild(spawnPoint5)
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
                        let square = SKSpriteNode(texture: textures[0])
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
    
    func createNonFallTile(_ tilemap: SKTileMapNode) {
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
                        
                        let square = SKSpriteNode(texture: textures[0])
                        square.position = tilePos
                        square.physicsBody = SKPhysicsBody(rectangleOf: textureSize)
                        square.physicsBody?.isDynamic = false
                        square.physicsBody?.affectedByGravity = false
                        square.physicsBody?.restitution = 0.0
                        square.physicsBody?.allowsRotation = false
                        square.physicsBody?.usesPreciseCollisionDetection = true
                        square.name = "nofallplatform"
                        square.zPosition = 20.0
                        square.physicsBody?.categoryBitMask = physicsCategory.nofallplatform.rawValue
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
                        
                        var inimigo = self.giveEnemy()
                        if self.hasChaser == true{
                            inimigo = Inimigo()
                        } else if inimigo == Chaser(){
                            self.hasChaser = true
                        }
                        inimigo.zPosition = 21.0
                        inimigo.numSpawn = 1
                        inimigo.position = spawnPoint.position
                        
                        if target.position.x < spawnPoint.position.x{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnL1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnL, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        } else{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnD1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnR, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        }
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
                        
                        var inimigo = self.giveEnemy()
                        if self.hasChaser == true{
                            inimigo = Inimigo()
                        } else if inimigo == Chaser(){
                            self.hasChaser = true
                        }
                        inimigo.zPosition = 21.0
                        inimigo.numSpawn = 2
                        inimigo.position = spawnPoint.position
                        if target.position.x < spawnPoint.position.x{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnL1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnL, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        } else{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnD1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnR, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        }
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
                        
                        var inimigo = self.giveEnemy()
                        if self.hasChaser == true{
                            inimigo = Inimigo()
                        } else if inimigo == Chaser(){
                            self.hasChaser = true
                        }
                        inimigo.zPosition = 21.0
                        inimigo.numSpawn = 3
                        inimigo.position = spawnPoint.position
                        if target.position.x < spawnPoint.position.x{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnL1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnL, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        } else{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnD1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnR, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        }
                    }
                }
            }
        }
    }
    
    func InimigoSpawn4(target: Player){
        enumerateChildNodes(withName: "spawnPoint4"){ node, _ in
            if let spawnPoint = node as? SKSpriteNode{
                
                if self.inimigosAR.count < self.limiteInimigos{
                    
                    let verificaPos = self.verificaPosição(spawnNum: 4)
                    
                    if verificaPos{
                        
                        var inimigo = self.giveEnemy()
                        if self.hasChaser == true{
                            inimigo = Inimigo()
                        } else if inimigo == Chaser(){
                            self.hasChaser = true
                        }
                        inimigo.zPosition = 21.0
                        inimigo.numSpawn = 4
                        inimigo.position = spawnPoint.position
                        if target.position.x < spawnPoint.position.x{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnL1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnL, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        } else{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnD1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnR, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        }
                    }
                }
            }
        }
    }
    func InimigoSpawn5(target: Player){
        enumerateChildNodes(withName: "spawnPoint5"){ node, _ in
            if let spawnPoint = node as? SKSpriteNode{
                
                if self.inimigosAR.count < self.limiteInimigos{
                    
                    let verificaPos = self.verificaPosição(spawnNum: 5)
                    
                    if verificaPos{
                        var inimigo = self.giveEnemy()
                        if self.hasChaser == true{
                            inimigo = Inimigo()
                        } else if inimigo == Chaser(){
                            self.hasChaser = true
                        }
                        inimigo.zPosition = 21.0
                        inimigo.numSpawn = 5
                        inimigo.position = spawnPoint.position
                        if target.position.x < spawnPoint.position.x{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnL1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnL, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        } else{
                            spawnPoint.texture = SKTexture(imageNamed: "spawnD1")
                            
                            let spawAnimation = SKAction.animate(with: self.spawnR, timePerFrame: 0.1)
                            let animationEnded = SKAction.run {
                                spawnPoint.texture = nil
                            }
                            let createEnemy = SKAction.run {
                                self.addChild(inimigo)
                                self.inimigosAR.append(inimigo)
                                inimigo.target = target
                            }
                            spawnPoint.run(.sequence([spawAnimation,animationEnded,createEnemy]))
                        }
                    }
                }
            }
        }
    }
    
    func verificaPosição(spawnNum:Int) -> Bool{
        if inimigosAR == []{
            return true
        }else{
            for inimigo in self.inimigosAR {
                let dx = distanceX(a: inimigo.position, b: spawnPoints[spawnNum-1].position)
                if dx < 200{
                    return false
                }
            }
            return true
        }
    }
    
    func giveEnemy() -> Inimigo{
        let decider = Int.random(in: 1...100)
        
        if decider > 20 {
            return Inimigo()
        } else {
            return Chaser()
        }
    }
}

