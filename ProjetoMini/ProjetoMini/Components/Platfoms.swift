//
//  Platfoms.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 13/07/23.
//

import SpriteKit

// MARK: parent class that initialize the physics of all platforms

class Platform: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color , size: size)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LongPlatform: Platform {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.categoryBitMask = physicsCategory.platform.rawValue
        self.physicsBody?.collisionBitMask = physicsCategory.player.rawValue
        
        self.color = .blue
        self.size = CGSize(width: 100, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
