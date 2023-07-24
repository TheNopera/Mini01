//
//  MenuScene.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 19/07/23.
//

import SpriteKit

class MenuScene: SKScene {
    
    let menuSceneNode = HUDNode()

    override func didMove(to view: SKView) {
      
        addChild(menuSceneNode)
        menuSceneNode.skView = view
        menuSceneNode.easeMenuScene = self
        menuSceneNode.setupMenu()
        
    }
        
}
