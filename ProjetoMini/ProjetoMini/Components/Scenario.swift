//
//  Scenario.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 13/07/23.
//

import Foundation
import SpriteKit

// MARK: parent class that contains all platforms
class Scenario: SKNode {
    
    var longPlatform = LongPlatform()
    
    override init() {
        super.init()
        longPlatform.position = CGPoint(x: -100, y: -100)
        self.addChild(longPlatform)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
