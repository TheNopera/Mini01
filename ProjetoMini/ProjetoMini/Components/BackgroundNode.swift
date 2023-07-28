//
//  BackgroundNode.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 24/07/23.
//

import Foundation
import SpriteKit

class BackgroundNode: SKNode {
    
    var gameSky = SKSpriteNode(imageNamed: "game-sky")
    var gameStars = SKEmitterNode(fileNamed: "Estrelas")
    var gameBehindSea = SKSpriteNode(imageNamed: "game_behindsea")
    var gameBoat = SKSpriteNode(imageNamed: "game-boat")
    var gameFrontSea = SKSpriteNode(imageNamed: "game-frontsea")
    var frontCLouds = CloudEmitter(back: false, finalPos: CGPoint(x: 2000, y: 0))
    
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
        
        gameBoat.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.45)
        gameBoat.zPosition = 4.0
        addChild(gameBoat)
        
        gameFrontSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*(-0.5))
        gameFrontSea.zPosition = 5.0
        addChild(gameFrontSea)
        
        frontCLouds.position = CGPoint(x: -600 , y: screenHeight*(-0.4))
        frontCLouds.zPosition = 21.0
        addChild(frontCLouds)
    }
}
