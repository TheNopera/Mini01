//
//  HUDNode.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 17/07/23.
//

import SpriteKit

class HUDNode: SKNode {
    
    // MARK: Properties
    var gameOverShape: SKShapeNode!
    var gameOverNode: SKSpriteNode!
    
    var menuNode: SKSpriteNode!
    var againNode: SKSpriteNode!
}


// MARK: GameOver

extension HUDNode {
    
    func setupGameOver() {
        
        gameOverShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        gameOverShape.zPosition = 49.0
        gameOverShape.fillColor = UIColor(red: 217, green: 217, blue: 217, alpha: 0.7)
        addChild(gameOverShape)
        
        // MARK: GameOver Node
        gameOverNode = SKSpriteNode(imageNamed: "panel-gameOver")
        gameOverNode.zPosition = 50.0
        gameOverNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        addChild(gameOverNode)
        
        // MARK: Menu Node
        menuNode = SKSpriteNode(imageNamed: "menu-button")
        menuNode.zPosition = 55.0
        menuNode.position = CGPoint(
            x: gameOverNode.frame.minX + 80,
            y: gameOverNode.frame.minY + menuNode.frame.height/2 + 30)
        menuNode.name = "Menu"
        addChild(menuNode)
        
        // MARK: PlayAgain Node
        againNode = SKSpriteNode(imageNamed: "again-button")
        againNode.zPosition = 55.0
        againNode.position = CGPoint(
            x: gameOverNode.frame.maxX - 80,
            y: gameOverNode.frame.minY + menuNode.frame.height/2 + 30)
        againNode.name = "Play Again"
        addChild(againNode)
    }
}
