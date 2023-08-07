//
//  JumpingLeft.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 25/07/23.
//

import GameplayKit

class jumpingLeftState:GKState{
    weak var gameScene: GameScene?
    
    //MARK: DID ENTER
    ///This function runs everytime this state is called.
    override func didEnter(from previousState: GKState?) {
        gameScene?.player.removeAction(forKey: "animation")
        let jumpAnimation = SKAction.animate(with: (gameScene?.player.jumpLeftAnimation)! , timePerFrame: 0.1)
        gameScene?.player.run(.repeatForever(jumpAnimation),withKey: "animation")
    }
  
    //MARK: UPDATE
    ///Called every frame
    override func update(deltaTime seconds: TimeInterval) {
        ///Get acess to objects in the scene
        let p = gameScene?.player
        let jstick = gameScene?.joystick
        
        ///Check if player is dead
        if (p?.vidas)! <= 0{
            gameScene?.stateMachine?.enter(isDeadLeft.self)
        }
        ///Check if player is  idle turning to the left
        else if (p?.physicsBody?.velocity.dy)! == 0{
            gameScene?.stateMachine?.enter(isIdleLeft.self)
        }
        ///Check if player is jumping turning to the right
        else if jstick!.displacement > 0 {
            gameScene?.stateMachine?.enter(jumpingRightState.self)
        } 
    }
}
