//
//  HUDNode.swift
//  ProjetoMini
//
//  Created by Mateus Martins Pires on 17/07/23.
//

import SpriteKit

class HUDNode: SKNode {
    
    // MARK: Pre Game Properties
    
    // Pre Game View
    private var menuShape: SKShapeNode!
    private var menuNode: SKSpriteNode!
    private var startNode: SKLabelNode!
    
    // Settings
    private var configShape: SKSpriteNode!
    private var configTitle: SKLabelNode!
    private var soundLabel: SKLabelNode!
    private var soundNode: SKSpriteNode!
    private var musicLabel: SKLabelNode!
    private var musicNode: SKSpriteNode!
    private var returnLabel: SKLabelNode!
    private var returnNode: SKSpriteNode!
    private var returnPressNode: SKSpriteNode!
   
    
    // Sound and Music Properties
    private var isSoundOn = false
    private let soundKey = "SoundKey" // UserDefault key for sound
    private var isMusicOn = false
    private let musicKey = "MusicKey" // UserDefault key for music

    
    // MARK: In Game Properties
    
    // InGame Settings "Return" Button
    private var inGameReturnNode: SKSpriteNode!
    private var InGameReturnPressNode: SKSpriteNode!
    
    // Pause Panel Properties
    private var inGamePauseNode: SKSpriteNode!
    private var tituloPause: SKLabelNode!
    private var pauseNodeShape: SKShapeNode!
    private var pauseNode: SKSpriteNode!
    private var resumeNode: SKSpriteNode!
    private var restartNode: SKSpriteNode!
    private var configNode: SKSpriteNode!
    private var quitNode: SKSpriteNode!
    var gamePaused = false
    
    // In Game Timer Properties
    var renderTime: TimeInterval = 0.0
    var changeTime: TimeInterval = 1.0
    var seconds: Int = 0
    var minutes: Int = 0
    var timerLabel: SKLabelNode!
    
    // Player Life Nodes Properties
    var lifeNodes: [SKSpriteNode] = []
    var life1: SKSpriteNode!
    var life2: SKSpriteNode!
    var life3: SKSpriteNode!
    
    
    // MARK: GameOver Properties
    
    // GameOver View Properties
    private var gameOverShape: SKShapeNode!
    private var gameOverNode: SKSpriteNode!
    
    // Score and HighScore Label
    private var scoreTitleLbl: SKLabelNode!
    private var scoreLbl: SKLabelNode!
    private var highscoreLbl: SKLabelNode!
    private var highscoreTitleLbl: SKLabelNode!
    
    // Home Button
    private var homeNode: SKSpriteNode!
    private var homeLabel: SKLabelNode!
    private var homePressNode: SKSpriteNode!
    
    // Play Again Button
    private var againNode: SKSpriteNode!
    private var againLabel: SKLabelNode!
    private var againPressNode: SKSpriteNode!

    
    private var gameOverLabel: SKLabelNode!
    
    

    // MARK: Transition Properties
    
    // Properties for SKScene Transition (MenuScene -> GameScene)
    var easeMenuScene: MenuScene?
    var easeGameScene: GameScene?
    var skView: SKView!
    
    private var isStart = false {
        didSet {
            updateBtn(node: startNode, event: isStart)
        }
    }
    private var isConfig = false {
        didSet {
            updateBtn(node: menuSettings, event: isConfig)
        }
    }
    private var inGameConfig = false {
        didSet {
            updateBtn(node: configNode, event: inGameConfig)
        }
    }
    private var inGameReturn = false {
        didSet {
            updateBtn(node: InGameReturnPressNode, event: inGameReturn)
        }
    }
    private var isSound = false {
        didSet {
            updateBtn(node: soundNode, event: isSound)
        }
    }
    private var isMusic = false {
        didSet {
            updateBtn(node: musicNode, event: isMusic)
        }
    }
    private var isReturn = false {
        didSet {
            updateBtn(node: returnPressNode, event: isReturn)
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
    private var isRestart = false {
        didSet {
            updateBtn(node: restartNode, event: isRestart)
        }
    }
    private var IsHome = false {
        didSet {
        updateBtn(node: homePressNode, event: IsHome)
        }
    }
    
    private var isAgain = false {
        didSet {
            updateBtn(node: againPressNode, event: isAgain)
        }
    }
    
    var menuSky = SKSpriteNode(imageNamed: "menu-ceu")
    var menuStarsBack = SKEmitterNode(fileNamed: "estrelasBolinha")
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
    var menuBoatTexture = [
        SKTexture(imageNamed: "menu-barco"),
        SKTexture(imageNamed: "menu-barco2"),
        SKTexture(imageNamed: "menu-barco3")
    ]
    var menuOndasBack = [
        SKTexture(imageNamed: "menu-maratras"),
        SKTexture(imageNamed: "menu-maratras2"),
        SKTexture(imageNamed: "menu-maratras3")
    ]
    var menuOndasFront = [
        SKTexture(imageNamed: "menu-marfrente"),
        SKTexture(imageNamed: "menu-marfrente2"),
        SKTexture(imageNamed: "menu-marfrente3")
    ]
    
    
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
        
        if node.name == "Configuration" && !isConfig {
            isConfig = true
        }
        
        if node.name == "Sound" && !isSound {
            isSound = true
        }
        
        if node.name == "Music" && !isMusic {
            isMusic = true
        }
        
        if node.name == "Return from Config" && !isReturn {
            isReturn = true
        }
        
        // PAUSED GAME
        if node.name == "Pause" && !isPause {
            isPause = true
            print("PauseButton")
        }
        
        if node.name == "Resume" && !isResume {
            isResume = true
          
        }
        
        if node.name == "InGameConfig" && !inGameConfig {
            inGameConfig = true
        }
        if node.name == "Return from InGameConfig" && !inGameReturn {
            inGameReturn = true
        }
        if node.name == "Restart" && !isRestart {
            isRestart = true
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
        
        if isConfig {
            setupConfigMenu()
            startNode.isHidden = true
            isConfig = false
        }
        
        if isSound {

            toggleSound()
            isSound = false
            
        }
        
        if isMusic {
            toggleMusic()
            isMusic = false
        }
        if isReturn {
            configShape.removeFromParent()
            configTitle.removeFromParent()
            soundLabel.removeFromParent()
            soundNode.removeFromParent()
            musicLabel.removeFromParent()
            musicNode.removeFromParent()
            returnNode.removeFromParent()
            returnLabel.removeFromParent()

            startNode.isHidden = false
            isReturn = false
        }
        
        //PAUSED GAME
        if isPause {
            print("Botão Pause foi clicado")
            setupPausePanel()
            setupResumeNode()
            scene?.isPaused = true
            isPause = false
            gamePaused = true
        }
        
        if isResume {
            pauseNode.removeFromParent()
            quitNode.removeFromParent()
            tituloPause.removeFromParent()
            restartNode.removeFromParent()
            resumeNode.removeFromParent()
            configNode.removeFromParent()
            scene?.isPaused = false
            isResume = false
            print("is resume recebe false")
            gamePaused = false
            
        }
        
        if inGameConfig {
            pauseNode.removeFromParent()
            quitNode.removeFromParent()
            tituloPause.removeFromParent()
            restartNode.removeFromParent()
            configNode.removeFromParent()
            setupConfigInGame()
            inGameConfig = false
        }
        
        if inGameReturn {
            configShape.removeFromParent()
            configTitle.removeFromParent()
            soundLabel.removeFromParent()
            soundNode.removeFromParent()
            musicLabel.removeFromParent()
            musicNode.removeFromParent()
            inGameReturnNode.removeFromParent()
            returnLabel.removeFromParent()
            inGameReturn = false
            setupPausePanel()
        }
        if isRestart {
            isRestart = false
            if let _ = easeGameScene {
                let scene = GameScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .fade(withDuration: 1.5))
            }
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
        
        if let parent = menuSettings.parent {
            isConfig = menuSettings.contains(touch.location(in: parent))
        }
        if let parent = restartNode?.parent {
            isResume = restartNode.contains(touch.location(in: parent))
        } else
        
        if let parent = quitNode?.parent {
            isQuit = quitNode.contains(touch.location(in: parent))
        } else
        
        if let parent = homeNode?.parent {
            IsHome = homeNode.contains(touch.location(in: parent))
        } else
        
        if let parent = restartNode?.parent {
            isAgain = restartNode.contains(touch.location(in: parent))
        }
    }
}


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

// MARK: PRE GAME
extension HUDNode {
    
    // Create all the menu view
    func setupMenu() {
        
        menuShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        menuShape.strokeColor = SKColor(ciColor: .clear)
        menuShape.zPosition = 56.1
        menuShape.name = "Start"
        addChild(menuShape)
        
        isUserInteractionEnabled = true
        
        // Sky Sprite
        menuSky = SKSpriteNode(imageNamed: "menu-ceu")
        menuSky.zPosition = 49.0
        menuSky.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        addChild(menuSky)
        
        // Star Sprite
        menuStarsBack?.zPosition = 49.0
        menuStarsBack?.position = CGPoint(x: 0, y: screenHeight)
        if let emissor = menuStarsBack{
            emissor.advanceSimulationTime(180.0)
            addChild(emissor)
        }
        
        
        starEmitter?.zPosition = 50.0
        starEmitter?.position = CGPoint(x: 0, y: screenHeight)
        if let emissor = starEmitter{
            emissor.advanceSimulationTime(120.0)
            addChild(emissor)
        }
        
        // Behind Sea Sprite
        menuBehindSea = SKSpriteNode(imageNamed: "menu-maratras")
        menuBehindSea.zPosition = 51.0
        menuBehindSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.1)
        addChild(menuBehindSea)
        menuBehindSea.run(.repeatForever(.animate(with: menuOndasBack, timePerFrame: 0.5)))
        
        let mover1 = SKAction.move(to: CGPoint(x: screenWidth + 300 , y: screenHeight*0.15), duration: 8.0)
        startBackCloud.zPosition = 52.0
        startBackCloud.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.15)
        addChild(startBackCloud)
        startBackCloud.run(.sequence([mover1,.removeFromParent()]))
        
        menuCloudEmitter2.zPosition = 52.0
        menuCloudEmitter2.position = CGPoint(x: 0 - menuCloudEmitter2.size.width, y: screenWidth*0.15)
        addChild(menuCloudEmitter2)
        
        // Boat Sprite
        menuBoat = SKSpriteNode(imageNamed: "menu-barco")
        menuBoat.zPosition = 53.0
        menuBoat.setScale(0.75)
        menuBoat.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.45)
        addChild(menuBoat)
        menuBoat.run(.repeatForever(.animate(with: menuBoatTexture, timePerFrame: 0.3)))
        
        // Front Sea Sprite
        menuFrontSea = SKSpriteNode(imageNamed: "menu-marfrente")
        menuFrontSea.zPosition = 54.0
        menuFrontSea.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.1)
        addChild(menuFrontSea)
        menuFrontSea.run(.repeatForever(.animate(with: menuOndasFront, timePerFrame: 0.5)))
        
        let mover2 = SKAction.move(to: CGPoint(x: screenWidth + 300 , y: screenHeight*0.1), duration: 5.0)
        startFrontCLoud.zPosition = 55.0
        startFrontCLoud.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.1)
        addChild(startFrontCLoud)
        startFrontCLoud.run(.sequence([mover2,.removeFromParent()]))
        
        menuCloudEmitter1.zPosition = 55.0
        menuCloudEmitter1.position = CGPoint(x: 0 - menuCloudEmitter1.size.width, y: screenHeight*0.1)
        addChild(menuCloudEmitter1)
        
        // Forbidden Waters Logo
        menuLogo = SKSpriteNode(imageNamed: "logo")
        menuLogo.zPosition = 56.0
        menuLogo.setScale(0.75)
        menuLogo.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.65)
        addChild(menuLogo)
        
        // Settings Button
        menuSettings = SKSpriteNode(imageNamed: "menu-settings")
        menuSettings.zPosition = 56.2
        menuSettings.setScale(0.75)
        menuSettings.name = "Configuration"
        menuSettings.position = CGPoint(x: screenWidth*0.93, y: screenHeight*0.90)
        addChild(menuSettings)
        
        // Start Label
        startNode = SKLabelNode()
        startNode.text = "Press to start".localizaed()
        startNode.fontName = "JupiterCrashBRK"
        startNode.zPosition = 56.1
        startNode.position = CGPoint(
            x: screenWidth*0.5,
            y: screenHeight*0.25)
        addChild(startNode)
        
    }
}
// MARK: IN GAME

extension HUDNode {
 
    /// Creates and initializes the Game Timer
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
    
    /// Create Hearts for Player Life
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
    
    /// Setup Positions for the Hearts
    func setupLifePosition(_ life: SKSpriteNode, j: CGFloat) {
        
        life.zPosition = 49.0
        life.position = CGPoint(
            x: screenWidth * 0.1 + j,
            y: screenHeight * 0.90)
        addChild(life)
    }
}


extension HUDNode {
    
    /// Create Pause Button in GameScene
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
    
    /// Create Resume Button over the Pause Button when the Pause Button is pressed
    func setupResumeNode() {
        resumeNode = SKSpriteNode(imageNamed: "resume-button")
        resumeNode.name = "Resume"
        resumeNode.size = CGSize(width: 32, height: 32)
        resumeNode.zPosition = 55.0
        resumeNode.position = CGPoint(
            x: screenWidth*0.93,
            y: screenHeight*0.90)
        addChild(resumeNode)
        isUserInteractionEnabled = true
    }
    
    /// Create All Pause View
    func setupPausePanel() {
        
        isUserInteractionEnabled = true
        
        // Green Background
        pauseNode = SKSpriteNode(imageNamed: "NevoaDoFundo")
        pauseNode.zPosition = 50.0
        pauseNode.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        addChild(pauseNode)
        
        // Pause Label
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
        
        // Quit Button
        quitNode = SKSpriteNode(imageNamed: "home-button")
        quitNode.zPosition = 55.0
        quitNode.position = CGPoint(
            x: screenWidth*(0.35),
            y: screenHeight*(0.45))
        quitNode.name = "Quit"
        addChild(quitNode)
        
        // Restart Button
        restartNode = SKSpriteNode(imageNamed: "back-button")
        restartNode.zPosition = 55.0
        restartNode.position = CGPoint(
            x: screenWidth*(0.62),
            y: screenHeight*(0.45))
        restartNode.name = "Restart"
        addChild(restartNode)
        
        // Settings Button
        configNode = SKSpriteNode(imageNamed: "menu-settings")
        configNode.zPosition = 55.0
        configNode.position = CGPoint(
            x: screenWidth*(0.49),
            y: screenHeight*(0.45))
        configNode.name = "InGameConfig"
        addChild(configNode)
    }
}


extension HUDNode {
    
    /// Create Settings View on MenuScene
    func setupConfigMenu() {
        
        // Settings Green Background
        configShape = SKSpriteNode(imageNamed: "NevoaDoFundo")
        configShape.zPosition = 60.0
        configShape.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        addChild(configShape)
        
        // Settings Label Title
        configTitle = SKLabelNode(text: "Settings".localizaed())
        configTitle.zPosition = 60.0
        configTitle.fontName = "KarmaticArcade"
        configTitle.position = CGPoint(
            x: screenWidth*(0.49) + 3,
            y: screenHeight*(0.65))
        addChild(configTitle)
        
        // Sound Label
        soundLabel = SKLabelNode(text: "sound effects".localizaed())
        soundLabel.zPosition = 60.0
        soundLabel.fontName = "JupiterCrashBRK"
        soundLabel.fontSize = 20.0
        soundLabel.position = CGPoint(x: screenWidth*0.467, y: screenHeight*0.5)
        addChild(soundLabel)
        
        let savedSound: Bool = (UserDefaults.standard.integer(forKey: soundKey) != 0)
        
        // Sound Button
        soundNode = savedSound ? SKSpriteNode(imageNamed: "sound-on") : SKSpriteNode(imageNamed: "sound-off")
        soundNode.size = CGSize(width: 28, height: 28)
        soundNode.name = "Sound"
        soundNode.zPosition = 60.0
        soundNode.position = CGPoint(x: screenWidth*0.5 + 50, y: screenHeight*0.52)
        addChild(soundNode)
        
        // Music Label
        musicLabel = SKLabelNode(text: "music".localizaed())
        musicLabel.zPosition = 60.0
        musicLabel.fontName = "JupiterCrashBRK"
        musicLabel.fontSize = 20.0
        musicLabel.position = CGPoint(x: screenWidth*0.47, y: screenHeight*0.4)
        addChild(musicLabel)
        
        let savedMusic: Bool = (UserDefaults.standard.integer(forKey: musicKey) != 0)
        
        // Music Button
        musicNode = savedMusic ? SKSpriteNode(imageNamed: "music-on") : SKSpriteNode(imageNamed: "music-off")
        musicNode.zPosition = 60.0
        musicNode.name = "Music"
        musicNode.size = CGSize(width: 28, height: 28)
        musicNode.position = CGPoint(
            x: screenWidth/2 + 45,
            y: screenHeight*0.42)
        addChild(musicNode)
        
        // Return Label
        returnLabel = SKLabelNode()
        returnLabel.text = "return".localizaed()
        returnLabel.fontSize = 20.0
        returnLabel.fontName = "JupiterCrashBRK"
        returnLabel.color = .white
        returnLabel.zPosition = 61.1
        returnLabel.position = CGPoint(
            x: screenWidth*(0.5),
            y: screenHeight*0.23)
        addChild(returnLabel)
        
        // Return Button
        returnNode = SKSpriteNode(imageNamed: "Button")
        returnNode.zPosition = 61.0
        returnNode.position = CGPoint(
            x: screenWidth*(0.5),
            y: screenHeight*0.25)
        addChild(returnNode)
        
        // Invisible Press Node for "Return Button"
        returnPressNode = SKSpriteNode()
        returnPressNode.name = "Return from Config"
        returnPressNode.size = CGSize(width: returnNode.size.width, height: returnNode.size.height)
        returnPressNode.zPosition = 61.2
        returnPressNode.position = CGPoint(
            x: screenWidth*(0.5),
            y: screenHeight*0.25)
        addChild(returnPressNode)
        
    }
    
    /// Create the Settings View on GameScene
    func setupConfigInGame() {
        
        // Recicled Settings Background
        configShape = SKSpriteNode(imageNamed: "NevoaDoFundo")
        configShape.zPosition = 60.0
        configShape.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        addChild(configShape)
        
        // Recicled Settings Label Title
        configTitle = SKLabelNode(text: "Settings".localizaed())
        configTitle.zPosition = 60.0
        configTitle.fontName = "KarmaticArcade"
        configTitle.fontSize = 40.0
        configTitle.position = CGPoint(
            x: screenWidth*(0.49) + 3,
            y: screenHeight*(0.65))
        addChild(configTitle)
        
        // Recicled Sound Label
        soundLabel = SKLabelNode(text: "sound effects".localizaed())
        soundLabel.zPosition = 60.0
        soundLabel.fontName = "JupiterCrashBRK"
        soundLabel.fontSize = 20.0
        soundLabel.position = CGPoint(x: screenWidth*0.467, y: screenHeight*0.5)
        addChild(soundLabel)
        
        let savedSound: Bool = (UserDefaults.standard.integer(forKey: soundKey) != 0)
        
        // Recicled Sound Button
        soundNode = savedSound ? SKSpriteNode(imageNamed: "sound-on") : SKSpriteNode(imageNamed: "sound-off")
        soundNode.size = CGSize(width: 28, height: 28)
        soundNode.name = "Sound"
        soundNode.zPosition = 60.0
        soundNode.position = CGPoint(x: screenWidth*0.5 + 50, y: screenHeight*0.52)
        addChild(soundNode)
        
        // Recicled Music Label
        musicLabel = SKLabelNode(text: "music".localizaed())
        musicLabel.zPosition = 60.0
        musicLabel.fontName = "JupiterCrashBRK"
        musicLabel.fontSize = 20.0
        musicLabel.position = CGPoint(x: screenWidth*0.47, y: screenHeight*0.4)
        addChild(musicLabel)
        
        let savedMusic: Bool = (UserDefaults.standard.integer(forKey: musicKey) != 0)
        
        // Recicled Music Button
        musicNode = savedMusic ? SKSpriteNode(imageNamed: "music-on") : SKSpriteNode(imageNamed: "music-off")
        musicNode.zPosition = 60.0
        musicNode.name = "Music"
        musicNode.size = CGSize(width: 28, height: 28)
        musicNode.position = CGPoint(
            x: screenWidth/2 + 50,
            y: screenHeight*0.42)
        addChild(musicNode)
        
        // Recicled Return Label
        returnLabel = SKLabelNode()
        returnLabel.text = "return".localizaed()
        returnLabel.fontSize = 20.0
        returnLabel.fontName = "JupiterCrashBRK"
        returnLabel.color = .white
        returnLabel.zPosition = 61.0
        returnLabel.position = CGPoint(
            x: screenWidth*(0.5),
            y: screenHeight*0.23)
        addChild(returnLabel)
        
        // New Return Button for IN GAME
        inGameReturnNode = SKSpriteNode(imageNamed: "Button")
        inGameReturnNode.zPosition = 60.0
        inGameReturnNode.position = CGPoint(
            x: screenWidth*(0.5),
            y: screenHeight*0.25)
        addChild(inGameReturnNode)
        
        // New Press Node for IN GAME Return Button
        InGameReturnPressNode = SKSpriteNode()
        InGameReturnPressNode.color = .clear
        InGameReturnPressNode.zPosition = 61.0
        InGameReturnPressNode.size = CGSize(width: inGameReturnNode.size.width, height: inGameReturnNode.size.height)
        InGameReturnPressNode.name = "Return from InGameConfig"
        InGameReturnPressNode.position = CGPoint(
            x: screenWidth*(0.5),
            y: screenHeight*0.25)
        addChild(InGameReturnPressNode)
        
        
    }
    
    /// toggle the var isSoundOn and saves it
    func toggleSound() {
        isSoundOn = !isSoundOn
        
        // let to save isSoundOn in User Defaults
        let savedSound: Bool = (UserDefaults.standard.integer(forKey: soundKey) != 0)
        
        if savedSound != isSoundOn {
            UserDefaults.standard.set(isSoundOn, forKey: soundKey)
        }
         
        let soundToggle = childNode(withName: "Sound") as! SKSpriteNode
        soundToggle.texture = isSoundOn ? SKTexture(imageNamed: "sound-on") : SKTexture(imageNamed: "sound-off")
        
    }
    
    /// toggle the var isMusicOn and saves it
    func toggleMusic() {
        
        isMusicOn = !isMusicOn
        
        // let to save isMusicOn in User Defaults
        let savedMusic: Bool = (UserDefaults.standard.integer(forKey: musicKey) != 0)
        
        if savedMusic != isMusicOn {
            UserDefaults.standard.set(isMusicOn, forKey: musicKey)
        }
        
        let musicToggle = childNode(withName: "Music") as! SKSpriteNode
        musicToggle.texture = isMusicOn ? SKTexture(imageNamed: "music-on") : SKTexture(imageNamed: "music-off")
        
    }
}

// MARK: GAMEOVER

extension HUDNode {
    
    ///Create all the GameOver View
    func setupGameOver(_ timer: String, _ hightimer: String) {
        
        // Green Background
        gameOverShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        gameOverShape.zPosition = 49.0
        addChild(gameOverShape)
        
        isUserInteractionEnabled = true
        
        // Green Background
        gameOverNode = SKSpriteNode(imageNamed: "NevoaDoFundo")
        gameOverNode.zPosition = 50.0
        gameOverNode.position = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        addChild(gameOverNode)
        
        // GameOver Title
        gameOverLabel = SKLabelNode()
        gameOverLabel.fontSize = 40.0
        gameOverLabel.fontColor = .white
        gameOverLabel.text = "Game Over".localizaed()
        gameOverLabel.fontName = "KarmaticArcade"
        gameOverLabel.zPosition = 55.0
        gameOverLabel.position = CGPoint(
            x: screenWidth/2 - 15,
            y: highscoreTitleLbl.position.y + 120)
        addChild(gameOverLabel)
        
        // Home Button Label
        homeLabel = SKLabelNode()
        homeLabel.fontSize = 20.0
        homeLabel.fontColor = .white
        homeLabel.text = "Menu".localizaed()
        homeLabel.fontName = "JupiterCrashBRK"
        homeLabel.zPosition = 55.0
        homeLabel.position = CGPoint(
            x: screenWidth*(0.35),
            y: screenHeight*0.23)
        addChild(homeLabel)
        
        // Home Button
        homeNode = SKSpriteNode(imageNamed: "Button")
        homeNode.zPosition = 55.0
        homeNode.position = CGPoint(
            x: screenWidth*(0.35),
            y: screenHeight*0.25)
        addChild(homeNode)
        
        // Press Node for Home Button
        homePressNode = SKSpriteNode()
        homePressNode.name = "Home"
        homePressNode.size = CGSize(width: homeNode.size.width, height: homeNode.size.height)
        homePressNode.zPosition = 55.1
        homePressNode.position = CGPoint(
            x: screenWidth*(0.35),
            y: screenHeight*0.25)
        addChild(homePressNode)
        
        // Again Button Label
        againLabel = SKLabelNode()
        againLabel.fontSize = 20.0
        againLabel.fontColor = .white
        againLabel.text = "Play again".localizaed()
        againLabel.fontName = "JupiterCrashBRK"
        againLabel.zPosition = 55.0
        againLabel.position = CGPoint(
            x: screenWidth*(0.62),
            y: screenHeight*0.23)
        addChild(againLabel)
        
        // Play Again Button
        againNode = SKSpriteNode(imageNamed: "Button")
        againNode.zPosition = 55.0
        againNode.position = CGPoint(
            x: screenWidth*(0.62),
            y: screenHeight*0.25)
        addChild(againNode)
        
        // Press Node for Play Again Button
        againPressNode = SKSpriteNode()
        againPressNode.name = "Again"
        againPressNode.size = CGSize(width: againNode.size.width, height: againNode.size.height)
        againPressNode.zPosition = 55.1
        againPressNode.position = CGPoint(
            x: screenWidth*(0.62),
            y: screenHeight*0.25)
        addChild(againPressNode)
        
        // Score Title Label
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
        
        // Score Label
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
        
        // Highscore Title Label
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
        
        // Highscore Label
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
        
    }
}


    
