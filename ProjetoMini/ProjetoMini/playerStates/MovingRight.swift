//
//  MovingRight.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 24/07/23.
//

import GameplayKit

class movingRightState:GKState{
    weak var gameScene: GameScene?
    
    override func didEnter(from previousState: GKState?) {
        gameScene?.player.removeAction(forKey: "animation")
        let walkAnimation = SKAction.animate(with: (gameScene?.player.moveRightAnimation)! , timePerFrame: 0.1, resize: false, restore: true)
        gameScene?.player.run(.repeatForever(walkAnimation),withKey: "animation")
    }
  
    override func willExit (to nextState: GKState) {}
    

    
    override func update(deltaTime seconds: TimeInterval) {
        let jstick = gameScene?.joystick
        let p = gameScene?.player
        
        if (p?.isJumping)! && (p?.physicsBody?.velocity.dy)! != 0{
            gameScene?.stateMachine?.enter(jumpingRightState.self)
        } else if jstick?.displacement == 0{
            gameScene?.stateMachine?.enter(isIdleRight.self)
        } else if jstick!.displacement < 0{
            gameScene?.stateMachine?.enter(movingLeftState.self)
        }
    }
}
