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
    
}


// MARK: GameOver

extension HUDNode {
    
    func setupGameOver() {
        let gameOverShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        gameOverShape.zPosition = 49.0
        gameOverShape.fillColor = UIColor(red: 0.2, green: 0.3, blue: 0.1, alpha: 0.7)
        addChild(gameOverShape)
        
        let gameOverNode = SKSpriteNode(imageNamed: "panel-gameOver")
        gameOverNode.zPosition = 50.0
        gameOverNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        addChild(gameOverNode)
        
    }
}
