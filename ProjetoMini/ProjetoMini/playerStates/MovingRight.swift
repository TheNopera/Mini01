//
//  MovingRight.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 24/07/23.
//

import GameplayKit

class movingRightState:GKState{
    weak var gameScene: GameScene?
    //MARK: DID ENTER
    ///This function runs everytime this state is called.
    override func didEnter(from previousState: GKState?) {
        gameScene?.player.removeAction(forKey: "animation")
        let walkAnimation = SKAction.animate(with: (gameScene?.player.moveRightAnimation)! , timePerFrame: 0.1)
        gameScene?.player.run(.repeatForever(walkAnimation),withKey: "animation")
    }
  
    

    //MARK: UPDATE
    ///Called every frame
    override func update(deltaTime seconds: TimeInterval) {
        ///Get acess to objects in the scene
        let jstick = gameScene?.joystick
        let p = gameScene?.player
        
        ///Check if player is dead
        if (p?.vidas)! <= 0{
            gameScene?.stateMachine?.enter(isDeadRight.self)
        }
        ///Check if player is jumping
        else if (p?.isJumping)! && (p?.physicsBody?.velocity.dy)! != 0{
            gameScene?.stateMachine?.enter(jumpingRightState.self)
        }
        ///Check if player is idle to the right
        else if jstick?.displacement == 0 && (p?.vidas)! > 0{
            gameScene?.stateMachine?.enter(isIdleRight.self)
        }
        ///Check if player is moving to the left
        else if jstick!.displacement < 0{
            gameScene?.stateMachine?.enter(movingLeftState.self)
        }
    }
}
