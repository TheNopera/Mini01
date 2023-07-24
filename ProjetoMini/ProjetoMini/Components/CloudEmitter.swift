//
//  CloudEmitter.swift
//  ProjetoMini
//
//  Created by Luca Lacerda on 24/07/23.
//

import SpriteKit

class CloudEmitter: SKSpriteNode{
    var back:Bool?
    var finalPos:CGPoint?
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let criarNuvens = SKAction.run {
            self.emitir(finalPos: self.finalPos!)
        }
        
        self.run(.repeatForever(.sequence([criarNuvens,.wait(forDuration: 3.0)])))
    }
    
    convenience init(back:Bool, finalPos: CGPoint){
        let texture = SKTexture(imageNamed: "nevoa1" )
        self.init(texture: texture , color: .clear, size: texture.size())
        self.back = back
        self.finalPos = finalPos
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func emitir(finalPos: CGPoint){
        let done = SKAction.removeFromParent()
        
        if !back!{
            let mover = SKAction.move(to: finalPos, duration: 6.0)
            let variation = Int.random(in: 3...4)
            let cloud = SKSpriteNode(imageNamed: "nevoa\(variation)")
            cloud.setScale(0.75)
            self.addChild(cloud)
            cloud.run(.sequence([mover,done]))
        }else{
            let mover = SKAction.move(to: finalPos, duration: 8.0)
            let variation = Int.random(in: 1...2)
            let cloud = SKSpriteNode(imageNamed: "nevoa\(variation)")
            cloud.setScale(0.75)
            self.addChild(cloud)
            cloud.run(.sequence([mover,done]))
        }
    }
}
