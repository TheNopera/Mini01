//
//  GameOver.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 17/07/23.
//

import SpriteKit

class GameOverScene: SKScene {
    
//    var menuButton = ButtonGameOver(image: .init(color: .blue, size: .init(width: 300, height: 100)), label: .init(text: "Menu"))
//
//    var restartButton = ButtonGameOver(image: .init(color: .blue, size: .init(width: 300, height: 100)), label: .init(text: "Restart"))
    
    var menuButton = SKSpriteNode(color: .systemIndigo, size: .init(width: 150, height: 50))
    var restartButton = SKSpriteNode(color: .blue, size: .init(width: 150, height: 50))
    
    override func didMove(to view: SKView) {
        
        
        menuButton.position = CGPoint(x: self.size.width*0.7, y: self.size.height*0.5)
        self.addChild(menuButton)
        
        restartButton.position = CGPoint(x: self.size.width*0.3, y: self.size.height*0.5)
        self.addChild(restartButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == restartButton {
                if let view = view {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                    
                }
            } else  if node == menuButton {
                if let view = view {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    // Scene goes to MenuScene that is being created
                    let scene:SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}

//class ButtonGameOver: SKNode {
//
//    var image: SKSpriteNode?
//    var label: SKLabelNode?
//
//    init(image: SKSpriteNode, label: SKLabelNode? = nil) {
//        super.init()
//        self.image = image
//        self.label = label
//        self.isUserInteractionEnabled = true
//
//        self.addChild(label!)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
