//
//  DeadLeft.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 26/07/23.
//

import GameplayKit

class isDeadLeft:GKState{
    weak var gameScene: GameScene?
    
    override func didEnter(from previousState: GKState?) {
        let idleAnimation = SKAction.animate(with: (gameScene?.player.deathAnimationL)! , timePerFrame: 0.1)
        gameScene?.player.removeAllActions()
        gameScene?.player.texture = nil
//        gameScene?.player.texture = SKTexture(imageNamed: "player_morte 2")
        gameScene?.player.size = CGSize(width: 64, height: (gameScene?.player.size.height)! )
        gameScene?.player.run(.sequence([idleAnimation, .wait(forDuration: 10)]))
        
    }
  
    override func willExit (to nextState: GKState) {}
   
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
         return stateClass == isDeadLeft.self
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        print("ESTOU MORTO")
    }
}

