//
//  Joystick.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 11/07/23.
//

import Foundation
import SpriteKit

class Joystick:SKNode{
    private var displacement:Double
    private var jBase:SKSpriteNode
    private var jHandle:SKSpriteNode
    var jPosition:UITouch
    
    override init(){
        displacement = 0
        jBase = SKSpriteNode(imageNamed: "Jbase")
        jHandle = SKSpriteNode(imageNamed: "Jhandle")
        jPosition = UITouch()
        super.init()
    
        
        jBase.size = CGSize(width: 100, height: 100)
        jBase.position = CGPoint(x: 0, y: 0)

        jHandle.size = CGSize(width: 40, height: 40)
        jHandle.position = CGPoint(x: 0, y: 0)
        self.addChild(jBase)
        self.addChild(jHandle)
    }
    
    func getDisplacement() -> Double{
        return self.displacement
    }
    
    func setDisplacement(value:Double){
        self.displacement = value
    }
    
    func moveJoystickToTouch(newPosition:CGPoint){
        self.jBase.position = newPosition
        self.jHandle.position = newPosition
    }
    
    func calculateDisplacement(touchLocation:CGPoint){
        let joystickMiddle = jBase.size.width * 0.5
        
        self.displacement = touchLocation.x - self.jHandle.position.x
        
        // Limit the handle's movement within the defined range
        let displacementLimited = max(-joystickMiddle, min(joystickMiddle, self.displacement))
        
        // Update the position of the handle
        self.jHandle.position = CGPoint(x: self.jBase.position.x + displacementLimited, y: self.jBase.position.y)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
