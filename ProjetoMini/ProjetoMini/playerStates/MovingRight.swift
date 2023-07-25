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
        let walkAnimation = SKAction.animate(with: (gameScene?.player.moveRightAnimation)! , timePerFrame: 0.1, resize: false, restore: true)
        gameScene?.player.run(.repeatForever(walkAnimation))
    }
  
    override func willExit (to nextState: GKState) {}
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        let jstick = gameScene?.joystick
        
        if jstick?.displacement == 0{
            return stateClass == isIdleRight.self
        } else if jstick!.displacement < 0{
            return stateClass == movingLeftState.self
        } 
        
        return stateClass == isIdleRight.self
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        let jstick = gameScene?.joystick
        
        if jstick?.displacement == 0{
            gameScene?.stateMachine?.enter(isIdleRight.self)
        } else if jstick!.displacement < 0{
            gameScene?.stateMachine?.enter(movingLeftState.self)
        }
    }
}
