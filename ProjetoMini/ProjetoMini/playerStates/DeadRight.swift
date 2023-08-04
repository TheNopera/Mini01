//
//  DeadRight.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 26/07/23.
//

import GameplayKit

class isDeadRight:GKState{
    weak var gameScene: GameScene?
    
    //MARK: DID ENTER
    ///This function runs everytime this state is called.
    override func didEnter(from previousState: GKState?) {
        let idleAnimation = SKAction.animate(with: (gameScene?.player.deathAnimationR)! , timePerFrame: 0.1)
        gameScene?.player.removeAllActions()
        gameScene?.player.texture = nil
        gameScene?.player.size = CGSize(width: 64, height: (gameScene?.player.size.height)! )
        gameScene?.player.run(.sequence([idleAnimation, .wait(forDuration: 10)]))
        
    }
   
    /// Run this function before changing states to hek if is allowed or not.
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
         return stateClass == isDeadRight.self
    }
}

