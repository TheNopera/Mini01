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
    var gameStars = SKSpriteNode(imageNamed: "game-stars")
    var gameBehindSea = SKSpriteNode(imageNamed: "game-behindsea")
    var gameBoat = SKSpriteNode(imageNamed: "game-boat")
    var gameFrontSea = SKSpriteNode(imageNamed: "game-frontsea")
    
    func setupBackgrounds() {
        
        gameSky.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        gameSky.zPosition = 1.0
        addChild(gameSky)
        
        gameStars.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        gameStars.zPosition = 2.0
        addChild(gameStars)
        
        gameBehindSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.1)
        gameBehindSea.zPosition = 3.0
        addChild(gameBehindSea)
        
        gameBoat.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.45)
        gameBoat.zPosition = 4.0
        addChild(gameBoat)
        
        gameFrontSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*(-0.5))
        gameFrontSea.zPosition = 5.0
        addChild(gameFrontSea)
    }
}
