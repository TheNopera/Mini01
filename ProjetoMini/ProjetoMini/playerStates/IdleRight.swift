//
//  IsIdle.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 24/07/23.
//

import GameplayKit

class isIdleRight:GKState{
    weak var gameScene: GameScene?
    
    override func didEnter(from previousState: GKState?) {
        gameScene?.player.removeAction(forKey: "animation")
        let idleAnimation = SKAction.animate(with: (gameScene?.player.idleAnimationR)! , timePerFrame: 0.1)
        gameScene?.player.run(.repeatForever(idleAnimation),withKey: "animation")
        
    }
  
    override func willExit (to nextState: GKState) {}
    
    override func update(deltaTime seconds: TimeInterval) {
        let jstick = gameScene?.joystick
        let p = gameScene?.player
        
        if (p?.vidas)! <= 0{
            gameScene?.stateMachine?.enter(isDeadRight.self)
        }
        if (p?.isJumping)! && (p?.physicsBody?.velocity.dy)! != 0{
            gameScene?.stateMachine?.enter(jumpingRightState.self)
        }else if jstick!.displacement > 0 && (p?.vidas)! > 0{
            gameScene?.stateMachine?.enter(movingRightState.self)
        }else if jstick!.displacement < 0{
            gameScene?.stateMachine?.enter(movingLeftState.self)
        }
        
        print("ESTOU VIVO")
    }
}

