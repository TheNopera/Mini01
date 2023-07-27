//
//  JumpingRight.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 25/07/23.
//

import GameplayKit

class jumpingRightState:GKState{
    weak var gameScene: GameScene?
    
    override func didEnter(from previousState: GKState?) {
        gameScene?.player.removeAction(forKey: "animation")
        let jumpAnimation = SKAction.animate(with: (gameScene?.player.jumpRightAnimation)! , timePerFrame: 0.1, resize: false, restore: false)
        gameScene?.player.run(.repeatForever(jumpAnimation),withKey: "animation")
    }
  
    override func willExit (to nextState: GKState) {}
    
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        return stateClass == isIdleRight.self
//    }
    
    override func update(deltaTime seconds: TimeInterval) {
        let p = gameScene?.player
        let jstick = gameScene?.joystick
        
        if (p?.vidas)! <= 0{
            gameScene?.stateMachine?.enter(isDeadRight.self)
        }
        else if (p?.physicsBody?.velocity.dy)! == 0 && (p?.vidas)! > 0{
            gameScene?.stateMachine?.enter(isIdleRight.self)
        }
        else if jstick!.displacement < 0 {
            gameScene?.stateMachine?.enter(jumpingLeftState.self)
        }
        
        
    }
}
