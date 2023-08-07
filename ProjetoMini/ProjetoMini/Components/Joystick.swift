//
//  Joystick.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 11/07/23.
//

import Foundation
import SpriteKit

class Joystick:SKNode{
    ///Contains the between the center of the joystick to the handle.
    var displacement:Double
    private var jBase:SKSpriteNode
    private var jHandle:SKSpriteNode
    ///Contains the joystick touch information
    var jPosition:UITouch
    
    override init(){
        displacement = 0
        jBase = SKSpriteNode(imageNamed: "Jbase")
        jHandle = SKSpriteNode(imageNamed: "Jhandle")
        jPosition = UITouch()
        super.init()
    
        ///Size of joystick
        jBase.size = CGSize(width: 100, height: 100)
        jBase.position = CGPoint(x: 0, y: 0)

        jHandle.size = CGSize(width: 40, height: 40)
        jHandle.position = CGPoint(x: 0, y: 0)
        self.addChild(jBase)
        self.addChild(jHandle)
    }
    
    //MARK: GET DISPLACEMENT
    func getDisplacement() -> Double{
        return self.displacement
    }
    //MARK: SET DISPLACEMENT
    func setDisplacement(value:Double){
        self.displacement = value
    }
    
    //MARK: SETS JOYSTICK POSITION TO THE TOUCH POSITION
    func moveJoystickToTouch(newPosition:CGPoint){
        self.jBase.position = newPosition
        self.jHandle.position = newPosition
    }
    //MARK: CALCULATES THE DISPLACEMENT
    func calculateDisplacement(touchLocation:CGPoint){
        ///Gets joystick base center
        let joystickMiddle = jBase.size.width * 0.5
        
        ///Distance between handle and joystick base center
        self.displacement = touchLocation.x - self.jBase.position.x
        
        // Limit the handle's movement within the defined range
        let displacementLimited = max(-joystickMiddle, min(joystickMiddle, self.displacement))
        
        // Update the position of the handle
        self.jHandle.position = CGPoint(x: self.jBase.position.x + displacementLimited, y: self.jBase.position.y)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
