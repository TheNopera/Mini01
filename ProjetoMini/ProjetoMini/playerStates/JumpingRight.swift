//
//  JumpingRight.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 25/07/23.
//

import GameplayKit

class jumpingRightState:GKState{
    weak var gameScene: GameScene?
    //MARK: DID ENTER
    ///This function runs everytime this state is called.
    override func didEnter(from previousState: GKState?) {
        gameScene?.player.removeAction(forKey: "animation")
        let jumpAnimation = SKAction.animate(with: (gameScene?.player.jumpRightAnimation)! , timePerFrame: 0.1, resize: false, restore: false)
        gameScene?.player.run(.repeatForever(jumpAnimation),withKey: "animation")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        ///Get acess to objects in the scene
        let p = gameScene?.player
        let jstick = gameScene?.joystick
        
        ///Check if player is dead
        if (p?.vidas)! <= 0{
            gameScene?.stateMachine?.enter(isDeadRight.self)
        }
        ///Check if player is idle to the right
        else if (p?.physicsBody?.velocity.dy)! == 0 && (p?.vidas)! > 0{
            gameScene?.stateMachine?.enter(isIdleRight.self)
        }
        ///Check if is jumping turning to the left
        else if jstick!.displacement < 0 {
            gameScene?.stateMachine?.enter(jumpingLeftState.self)
        }
        
        
    }
}
