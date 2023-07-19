//
//  HUDNode.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 17/07/23.
//

import SpriteKit

class HUDNode: SKNode {
    
    // MARK: Properties
    
    private var menuShape: SKShapeNode!
    private var menuNode: SKSpriteNode!
    
    private var startNode: SKSpriteNode!
    
    private var gameOverShape: SKShapeNode!
    private var gameOverNode: SKSpriteNode!
    
    private var homeNode: SKSpriteNode!
    private var againNode: SKSpriteNode!
    
    private var scoreTitleLbl: SKLabelNode!
    private var scoreLbl: SKLabelNode!
    private var highscoreLbl: SKLabelNode!
    private var highscoreTitleLbl: SKLabelNode!
    
    var easeMenuScene: MenuScene?
    var easeGameScene: GameScene?
    var skView: SKView!
    
    private var isStart = false {
        didSet {
            updateBtn(node: startNode, event: isStart)
        }
    }
    private var IsHome = false {
        didSet {
        updateBtn(node: homeNode, event: IsHome)
        }
    }
    
    private var isAgain = false {
        didSet {
            updateBtn(node: againNode, event: isAgain)
        }
    }
    
    // MARK: In touchesBegan, the buttons activate when pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let node = atPoint(touch.location(in: self))
        
        if node.name == "Start" && !isStart {
            isStart = true
            print("StartButton")
        }
        
        if node.name == "Home" && !IsHome {
            IsHome = true
            print("HomeButton")
        }
        
        if node.name == "Again" && !isAgain {
            isAgain = true
            print("AgainButton")
        }
    }
    
    // MARK: In touchesEnded, the buttons return to default configuration
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
        if isStart {
            isStart = false
            print("Start = false")
            
            if let _ = easeMenuScene {
                let scene = GameScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
        }
        
        if IsHome {
            IsHome = false
            print("Home = false")
            if let _ = easeGameScene {
                let scene = MenuScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }        }
        
        if isAgain {
            isAgain = false
           
            if let _ = easeGameScene {
                let scene = GameScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
        }
    }
    
    // MARK: In touchesMoved, when the user presses away from button, the action is cancelled
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        
        if let parent = startNode?.parent {
            isStart = startNode.contains(touch.location(in: parent))
        }
        
        if let parent = homeNode?.parent {
            IsHome = homeNode.contains(touch.location(in: parent))
        }
        
        if let parent = againNode?.parent {
            isAgain = againNode.contains(touch.location(in: parent))
        }
    }
}

// MARK: Setups

extension HUDNode {
    
    // MARK: Button Animation update
    private func updateBtn(node: SKNode, event: Bool) {
        var alpha: CGFloat = 1.0
        if event {
            alpha = 0.5
        }
        node.run(.fadeAlpha(to: alpha, duration: 0.1))
    }
}



// MARK: GameOver
extension HUDNode {
    
    func setupGameOver() {
        
        gameOverShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        gameOverShape.zPosition = 49.0
        gameOverShape.fillColor = UIColor(red: 217, green: 217, blue: 217, alpha: 0.7)
        addChild(gameOverShape)
        
        isUserInteractionEnabled = true
        
        // MARK: GameOver Node
        gameOverNode = SKSpriteNode(imageNamed: "panel-gameOver")
        gameOverNode.zPosition = 50.0
        gameOverNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        addChild(gameOverNode)
        
        // MARK: Menu Node
        homeNode = SKSpriteNode(imageNamed: "menu-button")
        homeNode.zPosition = 55.0
        homeNode.position = CGPoint(
            x: gameOverNode.frame.minX + 80,
            y: gameOverNode.frame.minY + homeNode.frame.height/2 + 5)
        homeNode.name = "Home"
        addChild(homeNode)
        
        // MARK: PlayAgain Node
        againNode = SKSpriteNode(imageNamed: "again-button")
        againNode.zPosition = 55.0
        againNode.position = CGPoint(
            x: gameOverNode.frame.maxX - 80,
            y: gameOverNode.frame.minY + homeNode.frame.height/2 + 5)
        againNode.name = "Again"
        addChild(againNode)
        
        // MARK: ScoreTitleLbl Node
        scoreTitleLbl = SKLabelNode()
        scoreTitleLbl.fontSize = 20.0
        scoreTitleLbl.fontColor = .white
        scoreTitleLbl.text = "Time:"
        scoreTitleLbl.zPosition = 55.0
        scoreTitleLbl.position = CGPoint(
            x: gameOverNode.frame.minX + scoreTitleLbl.frame.width/2 + 30,
            y: screenHeight/2)
        addChild(scoreTitleLbl)
        
        // MARK: ScoreLbl Node
        scoreLbl = SKLabelNode()
        scoreLbl.fontSize = 20.0
        scoreLbl.fontColor = .white
        scoreLbl.text = "0"
        scoreLbl.zPosition = 55.0
        scoreLbl.position = CGPoint(
            x: gameOverNode.frame.maxX + scoreLbl.frame.width/2 - 30,
            y: screenHeight/2)
        addChild(scoreLbl)
        
        // MARK: HighScoreTitleLbl Node
        highscoreTitleLbl = SKLabelNode()
        highscoreTitleLbl.fontSize = 20.0
        highscoreTitleLbl.fontColor = .white
        highscoreTitleLbl.text = "Best Time:"
        highscoreTitleLbl.zPosition = 55.0
        highscoreTitleLbl.position = CGPoint(
            x: gameOverNode.frame.minX + highscoreTitleLbl.frame.width/2 + 30,
            y: screenHeight/2 - highscoreTitleLbl.frame.height*2)
        addChild(highscoreTitleLbl)
        
        // MARK: HighScoreLbl Node
        highscoreLbl = SKLabelNode()
        highscoreLbl.fontSize = 20.0
        highscoreLbl.fontColor = .white
        highscoreLbl.text = "0"
        highscoreLbl.zPosition = 55.0
        highscoreLbl.position = CGPoint(
            x: gameOverNode.frame.maxX + highscoreLbl.frame.width/2 - 30,
            y: highscoreTitleLbl.position.y)
        addChild(highscoreLbl)
        
    }
}

// MARK: Menu
extension HUDNode {
    
    func setupMenu() {
        
        menuShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        menuShape.zPosition = 49.0
        menuShape.fillColor = UIColor(red: 217, green: 217, blue: 217, alpha: 0.7)
        addChild(menuShape)
        
        isUserInteractionEnabled = true
        
        // MARK: Menu Node
        menuNode = SKSpriteNode(imageNamed: "panel-menu")
        menuNode.zPosition = 50.0
        menuNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        addChild(menuNode)
        
        // MARK: Start Node
        startNode = SKSpriteNode(imageNamed: "start-button")
        startNode.zPosition = 55.0
        startNode.position = CGPoint(
            x: menuNode.frame.maxX - 80,
            y: menuNode.frame.minY + startNode.frame.height/2 + 5)
        startNode.name = "Start"
        addChild(startNode)
        
    }
}
