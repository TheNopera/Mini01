//
//  SwipeHandler.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 17/07/23.
//

import Foundation
import SpriteKit

class CustomSwipeHandler: NSObject {
    weak var scene: SKScene?
    weak var player: Player?

    init(scene: SKScene, player: Player) {
        super.init()
        self.scene = scene
        self.player = player
        configureSwipeGestureRecognizer()
    }

    
    private func configureSwipeGestureRecognizer() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .right // Change this to the desired direction
        scene?.view?.addGestureRecognizer(swipeGesture)
        swipeGesture.cancelsTouchesInView = false
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGestureLeft.direction = .left
        scene?.view?.addGestureRecognizer(swipeGestureLeft)
        swipeGestureLeft.cancelsTouchesInView = false
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGestureUp.direction = .up
        scene?.view?.addGestureRecognizer(swipeGestureUp)
        swipeGestureUp.cancelsTouchesInView = false
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGestureDown.direction = .down
        scene?.view?.addGestureRecognizer(swipeGestureDown)
        swipeGestureDown.cancelsTouchesInView = false
    }
    
    
    @objc private func handleSwipe(_ gestureRecognizer: UISwipeGestureRecognizer) {
        // Handle the swipe here
        let touchLocation = gestureRecognizer.location(in: scene?.view)
        // Call the handler function in the player class to perform specific actions.
        if touchLocation.x > (scene?.view?.bounds.width)! * 0.5{
            player?.handleSwipe(gestureRecognizer.direction)
        }
    
    }
}
