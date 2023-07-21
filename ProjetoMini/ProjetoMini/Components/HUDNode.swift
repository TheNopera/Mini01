//
//  HUDNode.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 17/07/23.
//

import SpriteKit

class HUDNode: SKNode {
    
    // MARK: PROPERTIES
    
    // MARK: Menu Panel
    private var menuShape: SKShapeNode!
    private var menuNode: SKSpriteNode!
    
    private var startNode: SKSpriteNode!
    
    // MARK: Paused Panel
    private var inGamePauseNode: SKSpriteNode!
    
    private var pauseNodeShape: SKShapeNode!
    private var pauseNode: SKSpriteNode!
    private var resumeNode: SKSpriteNode!
    private var quitNode: SKSpriteNode!
    
    // MARK: GameOver Panel
    private var gameOverShape: SKShapeNode!
    private var gameOverNode: SKSpriteNode!
    
    private var homeNode: SKSpriteNode!
    private var againNode: SKSpriteNode!
    
    private var scoreTitleLbl: SKLabelNode!
    private var scoreLbl: SKLabelNode!
    private var highscoreLbl: SKLabelNode!
    private var highscoreTitleLbl: SKLabelNode!
    
    
    // MARK: TRANSITION Properties
    var easeMenuScene: MenuScene?
    var easeGameScene: GameScene?
    var skView: SKView!
    
    private var isStart = false {
        didSet {
            updateBtn(node: startNode, event: isStart)
        }
    }
     var isPause = false {
        didSet {
            updateBtn(node: inGamePauseNode, event: isPause)
        }
    }
    private var isResume = false {
        didSet {
            updateBtn(node: resumeNode, event: isResume)
        }
    }
    private var isQuit = false {
        didSet {
            updateBtn(node: quitNode, event: isQuit)
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
        
        // START GAME
        if node.name == "Start" && !isStart {
            isStart = true
            print("StartButton")
        }
        
        // PAUSED GAME
        if node.name == "pause" && !isPause {
            isPause = true
            print("PauseButton")
        }
        
        if node.name == "resume" && !isResume {
            isResume = true
          
        }
        
        if node.name == "quit" && !isQuit {
           isQuit = true
        }
        
        // GAMEOVER
        if node.name == "Home" && !IsHome {
            IsHome = true
            print("HomeButton")
        }
        
        if node.name == "Again" && !isAgain {
            isAgain = true
            print("AgainButton")
        }
    }
    
    
    // MARK: In touchesEnded, the buttons take action and return to default configuration
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
        
        //START GAME
        if isStart {
            isStart = false
            print("Start = false")
            
            if let _ = easeMenuScene {
                let scene = GameScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
        }
        
        //PAUSED GAME
        if isPause {
            print("Botão Pause foi clicado")
            setupPausePanel()
            isPause = false
            scene?.isPaused = true
        }
        
        if isResume {
            pauseNode.removeFromParent()
            pauseNodeShape.removeFromParent()
            resumeNode.removeFromParent()
            quitNode.removeFromParent()
            scene?.isPaused = false
            isResume = false
            
        }
        
        if isQuit {
            isQuit = false
            if let _ = easeGameScene {
                let scene = MenuScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
        }
        
        //GAME OVER
        if IsHome {
            IsHome = false
            print("Home = false")
            if let _ = easeGameScene {
                let scene = MenuScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
        }
        
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
        
        if let parent = pauseNode?.parent {
            isPause = pauseNode.contains(touch.location(in: parent))
        }
        
        if let parent = resumeNode?.parent {
            isResume = resumeNode.contains(touch.location(in: parent))
        }
        
        if let parent = quitNode?.parent {
            isQuit = quitNode.contains(touch.location(in: parent))
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
    
    // MARK: Enter the GameOver Panel
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
    
    // MARK: Enter the Menu Panel
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

//MARK: Pause
extension HUDNode {
    
    // MARK: Enter the In Game Pause Button
    func setupPauseNode() {
        inGamePauseNode = SKSpriteNode(imageNamed: "pause-button")
//        inGamePauseNode.zPosition = 57.0
        inGamePauseNode.name = "pause"
        inGamePauseNode.position = CGPoint(
            x: screenWidth - 50,
            y: screenHeight - 50)
        addChild(inGamePauseNode)
        isUserInteractionEnabled = true

    }
    
    // MARK: Enter the Paused Panel
    func setupPausePanel() {
        pauseNodeShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        pauseNodeShape.zPosition = 49.0
        pauseNodeShape.fillColor = UIColor(red: 217, green: 217, blue: 217, alpha: 0.7)
        addChild(pauseNodeShape)
        
        isUserInteractionEnabled = true
        
        // MARK: Pause Node
        pauseNode = SKSpriteNode()
        pauseNode.zPosition = 49.0
        pauseNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        addChild(pauseNode)
        
        // MARK: Quit Node
        quitNode = SKSpriteNode(imageNamed: "menu-button")
        quitNode.zPosition = 55.0
        quitNode.position = CGPoint(
            x: pauseNode.frame.minX + 80,
            y: pauseNode.frame.minY + quitNode.frame.height/2 + 5)
        quitNode.name = "Quit"
        addChild(quitNode)
        
        // MARK: Resume Node
        resumeNode = SKSpriteNode(imageNamed: "again-button")
        resumeNode.zPosition = 55.0
        resumeNode.position = CGPoint(
            x: pauseNode.frame.maxX - 80,
            y: pauseNode.frame.minY + quitNode.frame.height/2 + 5)
        resumeNode.name = "Resume"
        addChild(resumeNode)
    }
}
