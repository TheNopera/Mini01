//
//  MenuScene.swift
//  ProjetoMini
//
//  Created by Victor Assis on 17/07/23.
//

import SpriteKit

class MenuScene: SKScene{
    
    var playButton = SKSpriteNode()
    var playButtonTex = SKTexture(imageNamed: "ButtonTeste")
    var configButton = SKSpriteNode()
    var configButtonTex = SKTexture(imageNamed: "ButtonTeste")
    
    override func didMove(to view: SKView) {
        
        playButton = SKSpriteNode(texture: playButtonTex)
        playButton.position = CGPoint(x: frame.midX, y: frame.minY)
        self.addChild(playButton)
        configButton = SKSpriteNode(texture: configButtonTex)
        playButton.position = CGPoint(x: self.size.width*1, y: self.size.height*1)
        self.addChild(configButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            let node2 = self.atPoint(pos)
            
            if node == playButton{
                if view != nil{
                    let transition: SKTransition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
            if node2 == configButton{
                if view != nil{
                    let transition2: SKTransition = SKTransition.fade(withDuration: 1)
                    let scene2: SKScene = ConfiguracaoScene(size: self.size)
                    self.view?.presentScene(scene2, transition: transition2)
                }
            }
        }
    }
}
