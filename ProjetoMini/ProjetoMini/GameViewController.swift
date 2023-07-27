//
//  GameViewController.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 06/07/23.
//
// OIIII :)

// OI TESTE 2
//teste_2
// testeLuca
// TESTE MATEUS

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MenuScene(size: view.bounds.size)
            if let view = self.view as! SKView?{
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                print(view.bounds.size)
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = false
//            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
