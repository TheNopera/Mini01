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
        let idleAnimation = SKAction.animate(with: (gameScene?.player.idleAnimationL)! , timePerFrame: 0.1, resize: false, restore: true)
        gameScene?.player.run(.repeatForever(idleAnimation))
        
    }
  
    override func willExit (to nextState: GKState) {}
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        let jstick = gameScene?.joystick
        
        if jstick!.displacement > 0{
            return stateClass == movingRightState.self
        } else if jstick!.displacement < 0{
            return stateClass == movingLeftState.self
        }
        
        return stateClass == isIdleLeft.self

    }
    
    override func update(deltaTime seconds: TimeInterval) {
        let jstick = gameScene?.joystick
        
        if jstick!.displacement > 0{
            gameScene?.stateMachine?.enter(movingRightState.self)
        } else if jstick!.displacement < 0{
            gameScene?.stateMachine?.enter(movingLeftState.self)
        }
    }
}

