//
//  DeadLeft.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 26/07/23.
//

import GameplayKit

class isDeadLeft:GKState{
    weak var gameScene: GameScene?
    
    //MARK: DID ENTER
    ///This function runs everytime this state is called.
    override func didEnter(from previousState: GKState?) {
        let idleAnimation = SKAction.animate(with: (gameScene?.player.deathAnimationL)! , timePerFrame: 0.1)
        gameScene?.player.removeAllActions()
        gameScene?.player.texture = nil
        gameScene?.player.size = CGSize(width: 64, height: (gameScene?.player.size.height)! )
        gameScene?.player.run(.sequence([idleAnimation, .wait(forDuration: 10)]))
        
    }
    
    //MARK: IS VALID NEXT STATE
    /// Run this function before changing states to hek if is allowed or not.
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
         return stateClass == isDeadLeft.self
    }

}

