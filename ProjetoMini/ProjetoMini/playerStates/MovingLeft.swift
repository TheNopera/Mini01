//
//  MovingLeft.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 24/07/23.
//

import GameplayKit

class movingLeftState:GKState{
    weak var gameScene:GameScene?
    
    override func didEnter(from previousState: GKState?) {
        let walkAnimation = SKAction.animate(with: (gameScene?.player.moveLeftAnimation)! , timePerFrame: 0.1, resize: false, restore: true)
        gameScene?.player.run(.repeatForever(walkAnimation))
    }
    
    override func willExit(to nextState: GKState) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        let jstick = gameScene?.joystick
        if jstick?.displacement == 0{
            return stateClass == isIdleLeft.self
        } else if jstick!.displacement > 0{
            return stateClass == movingRightState.self
        }
        
        return stateClass == isIdleLeft.self
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        let jstick = gameScene?.joystick
        
        if jstick?.displacement == 0{
            gameScene?.stateMachine?.enter(isIdleLeft.self)
        } else if jstick!.displacement > 0{
            gameScene?.stateMachine?.enter(movingRightState.self)
        }
    }
}
