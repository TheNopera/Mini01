//
//  BackgroundNode.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 24/07/23.
//

import Foundation
import SpriteKit

class BackgroundNode: SKNode {
    
    // MARK: SpriteNode Properties
    var gameSky = SKSpriteNode(imageNamed: "game-sky")
    var gameStars = SKEmitterNode(fileNamed: "Estrelas")
    var gameBehindSea = SKSpriteNode(imageNamed: "game_behindsea")
    var gameBoat = SKSpriteNode(imageNamed: "game-boat")
    var gameFrontSea = SKSpriteNode(imageNamed: "game-frontsea")
    var frontCLouds = CloudEmitter(back: false, finalPos: CGPoint(x: 2000, y: 0))
    var marfrenteAnimation = [
        SKTexture(imageNamed: "game-frontsea"),
        SKTexture(imageNamed: "game-frontsea2")
    ]
    var marAtrasAnimation = [
        SKTexture(imageNamed: "game_behindsea"),
        SKTexture(imageNamed: "game-behindsea2")
    ]
    var barcoAnimation = [
        SKTexture(imageNamed: "game-boat"),
        SKTexture(imageNamed: "game-boat2"),
        SKTexture(imageNamed: "game-boat3")
    ]
    
    /// Creates and setup a position for each scenario element
    func setupBackgrounds() {
        
        gameSky.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        gameSky.zPosition = 1.0
        addChild(gameSky)
        
        if let estrelas = gameStars{
            estrelas.position = CGPoint(x: -400 ,y: screenHeight*0.7)
            estrelas.advanceSimulationTime(800.0)
            estrelas.zPosition = 2.0
            addChild(estrelas)
        }
        
        gameBehindSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.1)
        gameBehindSea.zPosition = 3.0
        addChild(gameBehindSea)
        gameBehindSea.run(.repeatForever(.animate(with: marAtrasAnimation, timePerFrame: 0.4)))
        
        gameBoat.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.45)
        gameBoat.zPosition = 4.0
        addChild(gameBoat)
        gameBoat.run(.repeatForever(.animate(with: barcoAnimation, timePerFrame: 0.3)))
        
        gameFrontSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*(-0.5))
        gameFrontSea.zPosition = 5.0
        addChild(gameFrontSea)
        gameFrontSea.run(.repeatForever(.animate(with: marfrenteAnimation, timePerFrame: 0.4)))
        
        frontCLouds.position = CGPoint(x: -600 , y: screenHeight*(-0.3))
        frontCLouds.zPosition = 21.0
        addChild(frontCLouds)
    }
}
