//
//  HUDNode.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 17/07/23.
//

import SpriteKit

class HUDNode: SKNode {
    
    // MARK: PROPERTIES
    
    // MARK: Menu Properties
    private var menuShape: SKShapeNode!
    private var menuNode: SKSpriteNode!
    
    private var startNode: SKLabelNode!
    
    // MARK: Paused Properties
    private var inGamePauseNode: SKSpriteNode!
    
    private var pauseNodeShape: SKShapeNode!
    private var pauseNode: SKSpriteNode!
    private var resumeNode: SKSpriteNode!
    private var quitNode: SKSpriteNode!
    private var tituloPause: SKLabelNode!
    private var configNode: SKSpriteNode!
    var gamePaused = false
    
    // MARK: GameOver Properties
    private var gameOverShape: SKShapeNode!
    private var gameOverNode: SKSpriteNode!
    
    private var homeNode: SKSpriteNode!
    private var againNode: SKSpriteNode!
    
    private var tituloLBL: SKLabelNode!
    
    private var tituloButtonMenu: SKLabelNode!
    private var tituloButtonRejogar: SKLabelNode!
    
    private var scoreTitleLbl: SKLabelNode!
    var scoreLbl: SKLabelNode!
    private var highscoreLbl: SKLabelNode!
    private var highscoreTitleLbl: SKLabelNode!
    
    // MARK: InGame Properties
    var renderTime: TimeInterval = 0.0
    var changeTime: TimeInterval = 1.0
    var seconds: Int = 0
    var minutes: Int = 0
    var timerLabel: SKLabelNode!
    
    var lifeNodes: [SKSpriteNode] = []
    var life1: SKSpriteNode!
    var life2: SKSpriteNode!
    var life3: SKSpriteNode!

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
    
    var menuSky = SKSpriteNode(imageNamed: "menu-ceu")
    var menuStars = SKSpriteNode(imageNamed: "menu-estrela")
    var menuBehindSea = SKSpriteNode(imageNamed: "menu-maratras")
    var menuBoat = SKSpriteNode(imageNamed: "menu-barco")
    var menuFrontSea = SKSpriteNode(imageNamed: "menu-marfrente")
    var menuSettings = SKSpriteNode(imageNamed: "menu-settings")
    var menuLogo = SKSpriteNode(imageNamed: "logo")
    var menuCloudEmitter1 = CloudEmitter(back: false, finalPos: CGPoint(x: screenWidth + 800, y: 0))
    var menuCloudEmitter2 = CloudEmitter(back: true, finalPos: CGPoint(x: screenWidth + 800, y: 0))
    var startFrontCLoud = SKSpriteNode(imageNamed: "nevoa1")
    var startBackCloud = SKSpriteNode(imageNamed: "nevoa3")
    var starEmitter = SKEmitterNode(fileNamed: "Estrelas")
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
        if node.name == "Pause" && !isPause {
            isPause = true
            print("PauseButton")
        }
        
        if node.name == "Resume" && !isResume {
            isResume = true
          
        }
        
        if node.name == "Quit" && !isQuit {
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
                skView.presentScene(scene, transition: .fade(withDuration: 1.5))
            }
        }
        
        //PAUSED GAME
        if isPause {
            print("Botão Pause foi clicado")
            setupPausePanel()
            scene?.isPaused = true
            isPause = false
            gamePaused = true
        }
        
        if isResume {
            pauseNode.removeFromParent()
//            pauseNodeShape.removeFromParent()
            quitNode.removeFromParent()
            tituloPause.removeFromParent()
            resumeNode.removeFromParent()
            //configNode.removeFromParent()
            scene?.isPaused = false
            isResume = false
            print("is resume recebe false")
            gamePaused = false
            
        }
        
        if isQuit {
            isQuit = false
            if let _ = easeGameScene {
                let scene = MenuScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .fade(withDuration: 1.5))
            }
        }
        
        //GAME OVER
        if IsHome {
            IsHome = false
            print("Home = false")
            if let _ = easeGameScene {
                let scene = MenuScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .fade(withDuration: 1.5))
            }
        }
        
        if isAgain {
            isAgain = false
           
            if let _ = easeGameScene {
                let scene = GameScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .fade(withDuration: 1.5))
            }
        }
    }
    
    
    // MARK: In touchesMoved, when the user presses away from button, the action is cancelled
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        
        if let parent = startNode?.parent {
            isStart = startNode.contains(touch.location(in: parent))
        } else
        
//        if let parent = pauseNode?.parent {
//            isPause = pauseNode.contains(touch.location(in: parent))
//        } else
        
        /*
         Salvar o node tocado no touches began
         Se o node for diferente do update, cancela a funcao (comparação no touchesmoved)
         
         */
        if let parent = resumeNode?.parent {
            isResume = resumeNode.contains(touch.location(in: parent))
        } else
        
        if let parent = quitNode?.parent {
            isQuit = quitNode.contains(touch.location(in: parent))
        } else
        
        if let parent = homeNode?.parent {
            IsHome = homeNode.contains(touch.location(in: parent))
        } else
        
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
    func setupGameOver(_ timer: String, _ hightimer: String) {
        
        gameOverShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        gameOverShape.zPosition = 49.0
        addChild(gameOverShape)
        
        isUserInteractionEnabled = true
        
        // MARK: GameOver Node
        gameOverNode = SKSpriteNode(imageNamed: "NevoaDoFundo")
        gameOverNode.zPosition = 50.0
        gameOverNode.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        addChild(gameOverNode)
        
        // MARK: Menu Node
        homeNode = SKSpriteNode(imageNamed: "Button")
        homeNode.zPosition = 55.0
        homeNode.position = CGPoint(
            x: screenWidth*(0.35),
            y: screenHeight*0.25)
        homeNode.name = "Home"
        addChild(homeNode)
        
        // MARK: PlayAgain Node
        againNode = SKSpriteNode(imageNamed: "Button")
        againNode.zPosition = 55.0
        againNode.position = CGPoint(
            x: screenWidth*(0.62),
            y: screenHeight*0.25)
        againNode.name = "Again"
        addChild(againNode)
        
        // MARK: ScoreTitleLbl Node
        scoreTitleLbl = SKLabelNode()
        scoreTitleLbl.fontSize = 30.0
        scoreTitleLbl.fontColor = .white
        scoreTitleLbl.text = "Time:".localizaed()
        scoreTitleLbl.fontName = "JupiterCrashBRK"
        scoreTitleLbl.zPosition = 55.0
        scoreTitleLbl.position = CGPoint(
            x: gameOverNode.frame.width * 0.33,
            y: screenHeight/2)
        addChild(scoreTitleLbl)
        
        // MARK: ScoreLbl Node
        scoreLbl = SKLabelNode()
        scoreLbl.fontSize = 30.0
        scoreLbl.fontColor = .white
        scoreLbl.text = "\(timer)"
        scoreLbl.fontName = "JupiterCrashBRK"
        scoreLbl.zPosition = 55.0
        scoreLbl.position = CGPoint(
            x: screenWidth/2 + 90,
            y: screenHeight/2)
        addChild(scoreLbl)
        
        // MARK: HighScoreTitleLbl Node
        highscoreTitleLbl = SKLabelNode()
        highscoreTitleLbl.fontSize = 30.0
        highscoreTitleLbl.fontColor = .white
        highscoreTitleLbl.text = "Best Time:".localizaed()
        highscoreTitleLbl.fontName = "JupiterCrashBRK"
        highscoreTitleLbl.zPosition = 55.0
        highscoreTitleLbl.position = CGPoint(
            x: gameOverNode.frame.width * 0.33,
            y: screenHeight/2 - highscoreTitleLbl.frame.height*2)
        addChild(highscoreTitleLbl)
        
        // MARK: HighScoreLbl Node
        highscoreLbl = SKLabelNode()
        highscoreLbl.fontSize = 30.0
        highscoreLbl.fontColor = .white
        highscoreLbl.text = "\(hightimer)"
        highscoreLbl.fontName = "JupiterCrashBRK"
        highscoreLbl.zPosition = 55.0
        highscoreLbl.position = CGPoint(
            x: screenWidth/2 + 90,
            y: highscoreTitleLbl.position.y)
        addChild(highscoreLbl)
        
        tituloLBL = SKLabelNode()
        tituloLBL.fontSize = 40.0
        tituloLBL.fontColor = .white
        tituloLBL.text = "Game Over".localizaed()
        tituloLBL.fontName = "KarmaticArcade"
        tituloLBL.zPosition = 55.0
        tituloLBL.position = CGPoint(
            x: screenWidth/2 - 15,
            y: highscoreTitleLbl.position.y + 120)
        addChild(tituloLBL)
        
        tituloButtonMenu = SKLabelNode()
        tituloButtonMenu.fontSize = 20.0
        tituloButtonMenu.fontColor = .white
        tituloButtonMenu.text = "Menu".localizaed()
        tituloButtonMenu.fontName = "JupiterCrashBRK"
        tituloButtonMenu.zPosition = 55.0
        tituloButtonMenu.position = CGPoint(
            x: screenWidth*(0.35),
            y: screenHeight*0.23)
        addChild(tituloButtonMenu)
        
        tituloButtonRejogar = SKLabelNode()
        tituloButtonRejogar.fontSize = 20.0
        tituloButtonRejogar.fontColor = .white
        tituloButtonRejogar.text = "Play again".localizaed()
        tituloButtonRejogar.fontName = "JupiterCrashBRK"
        tituloButtonRejogar.zPosition = 55.0
        tituloButtonRejogar.position = CGPoint(
            x: screenWidth*(0.62),
            y: screenHeight*0.23)
        addChild(tituloButtonRejogar)
        
    }
}

// MARK: Menu
extension HUDNode {
    
    // MARK: Enter the Menu Panel
    func setupMenu() {
        
        menuShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        menuShape.strokeColor = SKColor(ciColor: .clear)
        menuShape.zPosition = 56.0
        menuShape.name = "Start"
        addChild(menuShape)
        
        isUserInteractionEnabled = true
        
        // MARK: Menu Node
        menuSky = SKSpriteNode(imageNamed: "menu-ceu")
        menuSky.zPosition = 49.0
        menuSky.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        addChild(menuSky)
        
        
        starEmitter?.zPosition = 50.0
        starEmitter?.position = CGPoint(x: 0, y: screenHeight)
        if let emissor = starEmitter{
            emissor.advanceSimulationTime(120.0)
            addChild(emissor)
        }
        
//        menuStars = SKSpriteNode(imageNamed: "menu-estrelas")
//        menuStars.zPosition = 50.0
//        menuStars.setScale(0.90)
//        menuStars.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
//        addChild(menuStars)
        
        menuBehindSea = SKSpriteNode(imageNamed: "menu-maratras")
        menuBehindSea.zPosition = 51.0
        menuBehindSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.1)
        addChild(menuBehindSea)
        
        let mover1 = SKAction.move(to: CGPoint(x: screenWidth + 300 , y: screenHeight*0.15), duration: 8.0)
        startBackCloud.zPosition = 52.0
        startBackCloud.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.15)
        addChild(startBackCloud)
        startBackCloud.run(.sequence([mover1,.removeFromParent()]))
        
        menuCloudEmitter2.zPosition = 52.0
        menuCloudEmitter2.position = CGPoint(x: 0 - menuCloudEmitter2.size.width, y: screenWidth*0.15)
        addChild(menuCloudEmitter2)
        
        menuBoat = SKSpriteNode(imageNamed: "menu-barco")
        menuBoat.zPosition = 53.0
        menuBoat.setScale(0.80)
        menuBoat.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.45)
        addChild(menuBoat)
        
        menuFrontSea = SKSpriteNode(imageNamed: "menu-marfrente")
        menuFrontSea.zPosition = 54.0
        menuFrontSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.1)
        addChild(menuFrontSea)
        
        let mover2 = SKAction.move(to: CGPoint(x: screenWidth + 300 , y: screenHeight*0.1), duration: 5.0)
        startFrontCLoud.zPosition = 55.0
        startFrontCLoud.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.1)
        addChild(startFrontCLoud)
        startFrontCLoud.run(.sequence([mover2,.removeFromParent()]))
        
        menuCloudEmitter1.zPosition = 55.0
        menuCloudEmitter1.position = CGPoint(x: 0 - menuCloudEmitter1.size.width, y: screenHeight*0.1)
        addChild(menuCloudEmitter1)
        
        
        // MARK: Menu Settings
        menuSettings = SKSpriteNode(imageNamed: "menu-settings")
        menuSettings.zPosition = 55.0
        menuSettings.setScale(0.75)
        menuSettings.position = CGPoint(x: screenWidth*0.93, y: screenHeight*0.90)
        addChild(menuSettings)
        
        menuLogo = SKSpriteNode(imageNamed: "logo")
        menuLogo.zPosition = 56.0
        menuLogo.setScale(0.75)
        menuLogo.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.65)
        addChild(menuLogo)
        
        
        // MARK: Start LabelNode
        startNode = SKLabelNode()
        startNode.text = "Press to start".localizaed()
        startNode.fontName = "JupiterCrashBRK"
        startNode.zPosition = 59.0
        startNode.position = CGPoint(
            x: screenWidth*0.5,
            y: screenHeight*0.25)
        addChild(startNode)
        
    }
}

//MARK: Pause
extension HUDNode {
    
    // MARK: Enter the In Game Pause Button
    func setupPauseNode() {
        inGamePauseNode = SKSpriteNode(imageNamed: "pause-button")
        inGamePauseNode.zPosition = 49.0
        inGamePauseNode.name = "Pause"
        inGamePauseNode.size = CGSize(width: 32, height: 32)
        inGamePauseNode.position = CGPoint(
            x: screenWidth*0.93,
            y: screenHeight*0.90)
        addChild(inGamePauseNode)
        isUserInteractionEnabled = true

    }
    
    // MARK: Enter the Paused Panel
    func setupPausePanel() {
//        pauseNodeShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
//        pauseNodeShape.zPosition = 50.0
//        pauseNodeShape.fillColor = UIColor(red: 217, green: 217, blue: 217, alpha: 0.7)
//        addChild(pauseNodeShape)
        
        isUserInteractionEnabled = true
        
        // MARK: Pause Node
        pauseNode = SKSpriteNode(imageNamed: "NevoaDoFundo")
        pauseNode.zPosition = 50.0
        pauseNode.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        addChild(pauseNode)
        
        // MARK: Quit Node
        quitNode = SKSpriteNode(imageNamed: "home-button")
        quitNode.zPosition = 55.0
        quitNode.position = CGPoint(
            x: screenWidth*(0.35),
            y: screenHeight*(0.45))
        quitNode.name = "Quit"
        addChild(quitNode)
        
        // MARK: Resume Node
        resumeNode = SKSpriteNode(imageNamed: "back-button")
        resumeNode.zPosition = 55.0
        resumeNode.position = CGPoint(
            x: screenWidth*(0.62),
            y: screenHeight*(0.45))
        resumeNode.name = "Resume"
        addChild(resumeNode)
        
        tituloPause = SKLabelNode()
        tituloPause.fontSize = 40.0
        tituloPause.fontColor = .white
        tituloPause.text = "Paused".localizaed()
        tituloPause.fontName = "KarmaticArcade"
        tituloPause.zPosition = 55.0
        tituloPause.position = CGPoint(
            x: screenWidth*(0.49) + 3,
            y: screenHeight*(0.65))
        addChild(tituloPause)
        
        /*configNode = SKSpriteNode(imageNamed: "menu-settings")
        configNode.zPosition = 55.0
        configNode.position = CGPoint(
            x: screenWidth*(0.49),
            y: screenHeight*(0.45))
        configNode.name = "Config"
        addChild(configNode)*/
    }
}

// MARK: InGame Timer
extension HUDNode {
    
    func setupInGameTimer() {
        timerLabel = SKLabelNode()
        timerLabel.zPosition = 49.0
        timerLabel.fontName = "JupiterCrashBRK"
        timerLabel.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.90)
        timerLabel.name = "Timer-label"
        addChild(timerLabel)
    }
}

extension HUDNode {
    
    func setupLife() {
        life1 = SKSpriteNode(imageNamed: "life-on")
        life2 = SKSpriteNode(imageNamed: "life-on")
        life3 = SKSpriteNode(imageNamed: "life-on")
        
        setupLifePosition(life1,j: 0.0)
        setupLifePosition(life2,j: 50.0)
        setupLifePosition(life3,j: 100.0)
        
        lifeNodes.append(life1)
        lifeNodes.append(life2)
        lifeNodes.append(life3)
    }

    func setupLifePosition(_ life: SKSpriteNode, j: CGFloat) {

        life.zPosition = 49.0
        life.position = CGPoint(
            x: screenWidth * 0.1 + j,
            y: screenHeight * 0.90)
        addChild(life)
    }
}

