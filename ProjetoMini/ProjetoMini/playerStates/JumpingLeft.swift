//
//  JumpingLeft.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 25/07/23.
//

import GameplayKit

class jumpingLeftState:GKState{
    weak var gameScene: GameScene?
    
    override func didEnter(from previousState: GKState?) {
        gameScene?.player.removeAction(forKey: "animation")
        let jumpAnimation = SKAction.animate(with: (gameScene?.player.jumpLeftAnimation)! , timePerFrame: 0.1, resize: false, restore: true)
        gameScene?.player.run(.repeatForever(jumpAnimation),withKey: "animation")
    }
  
    override func willExit (to nextState: GKState) {}
    
    
    override func update(deltaTime seconds: TimeInterval) {
        let p = gameScene?.player

        if (p?.physicsBody?.velocity.dy)! == 0{
            gameScene?.stateMachine?.enter(isIdleLeft.self)
        }
    }
}
