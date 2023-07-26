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
        let jumpAnimation = SKAction.animate(with: (gameScene?.player.jumpLeftAnimation)! , timePerFrame: 0.1)
        gameScene?.player.run(.repeatForever(jumpAnimation),withKey: "animation")
    }
  
    override func willExit (to nextState: GKState) {}
    
    
    override func update(deltaTime seconds: TimeInterval) {
        let p = gameScene?.player
        let jstick = gameScene?.joystick
        
        if (p?.vidas)! <= 0{
            gameScene?.stateMachine?.enter(isDeadLeft.self)
        }
        else if (p?.physicsBody?.velocity.dy)! == 0{
            gameScene?.stateMachine?.enter(isIdleLeft.self)
        }
        else if jstick!.displacement > 0 {
            gameScene?.stateMachine?.enter(jumpingRightState.self)
        } 
    }
}
