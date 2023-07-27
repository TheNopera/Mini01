//
//  IdleLeft.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 24/07/23.
//

import GameplayKit

class isIdleLeft:GKState{
    weak var gameScene: GameScene?
    
    override func didEnter(from previousState: GKState?) {
        gameScene?.player.removeAction(forKey: "animation")
        let idleAnimation = SKAction.animate(with: (gameScene?.player.idleAnimationL)! , timePerFrame: 0.1)
        gameScene?.player.run(.repeatForever(idleAnimation),withKey: "animation")
        
    }
  
    override func willExit (to nextState: GKState) {}
    
    
    override func update(deltaTime seconds: TimeInterval) {
        let jstick = gameScene?.joystick
        let p = gameScene?.player
        
        if (p?.vidas)! <= 0{
            gameScene?.stateMachine?.enter(isDeadLeft.self)
        }
        else if (p?.isJumping)! && (p?.physicsBody?.velocity.dy)! != 0{
            gameScene?.stateMachine?.enter(jumpingLeftState.self)
        }
        else if jstick!.displacement > 0{
            gameScene?.stateMachine?.enter(movingRightState.self)
        }
        else if jstick!.displacement < 0{
            gameScene?.stateMachine?.enter(movingLeftState.self)
        }
        
    }
}

