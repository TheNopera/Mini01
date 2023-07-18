//
//  ConfiguracaoScene.swift
//  ProjetoMini
//
//  Created by Victor Assis on 17/07/23.
//

import SpriteKit

class ConfiguracaoScene: SKScene{
    var returnButton = SKSpriteNode()
    var returnButtonTex = SKTexture(imageNamed: "ButtonTeste")
    
    override func didMove(to view: SKView) {
        returnButton = SKSpriteNode(texture: returnButtonTex)
        returnButton.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(returnButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == returnButton{
                if view != nil{
                    let transition: SKTransition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = MenuScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}

