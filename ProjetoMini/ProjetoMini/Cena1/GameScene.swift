//
//  GameScene.swift
//  ProjetoMini
//
//  Created by Daniel Ishida on 06/07/23.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let backgroundMusic = SKAudioNode(fileNamed: "BGMusic.m4a")
    var player:Player = Player()
    var joystick:Joystick = Joystick()
    let cameraPlayer = SKCameraNode()
    var displacement:Double = 0
    var lastUsedSpawn:Int = 0
    
    //MARK: file that contains all designed platforms
    let tileMapScenario: SKScene = SKScene(fileNamed: "ScenarioTileMap")!
    
    // MARK: instance of class LayerScenario
    let layerScenario = LayerScenario()
    
    // MARK: instance of class BackgroundNode
    let backgroundNode = BackgroundNode()
    
    // MARK: instance of class HUDNode
    let hudNode = HUDNode()
    
    var inGamePauseNode: SKSpriteNode!
    
    var stateMachine: GKStateMachine?
    
    
    var timerInSeconds: Int = 0
    private let easeScoreKey = "EaseScoreKey"
    
    override func didMove(to view: SKView) {
        print("teste")
        addChild(backgroundMusic)
       
        //backgroundSound.run(SKAction.play())
        // MARK: add physics to the world
        self.physicsWorld.contactDelegate = self
        
        // MARK: verify if tileMapScenario has a SKTileMapNode child
        if let tilemapNode = tileMapScenario.childNode(withName: "TileMapNode") as? SKTileMapNode {
            
            layerScenario.createTileMapColliders(tilemapNode)
            
        }
        
        // MARK: verify if tileMapScenario has a SKTileMapNode child
        if let nofallTile = tileMapScenario.childNode(withName: "NoFallTile") as? SKTileMapNode {
            
            layerScenario.createNonFallTile(nofallTile)
            
        }
        
        // MARK: center the scenario position in GameScene
        layerScenario.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        layerScenario.zPosition = 20.0
        self.addChild(layerScenario)
        layerScenario.addChild(cameraPlayer)
        layerScenario.addChild(player)
        
        player.zPosition = 20.0
        player.setupSwipeHandler()
        
        self.camera = cameraPlayer
        cameraPlayer.addChild(joystick)
        joystick.position = CGPoint(x: 0, y: 0)
        
        cameraPlayer.addChild(hudNode)
        hudNode.skView = view
        hudNode.easeGameScene = self
        hudNode.position = CGPoint(x: -screenWidth*0.5, y: -screenHeight*0.5)
        startGame()
        
        let cameraWidthBounds = self.frame.width/2
        let widthBounds = self.calculateAccumulatedFrame().width / 2 - cameraWidthBounds
        let cameraWidthConstraint = SKConstraint.positionX(.init(lowerLimit: -widthBounds, upperLimit: widthBounds))
        
        let cameraHeightBounds = self.calculateAccumulatedFrame().height/2
        let heightBounds = self.calculateAccumulatedFrame().height/2 - cameraHeightBounds
        let cameraHeightConstraint = SKConstraint.positionY(.init(lowerLimit: -cameraHeightBounds, upperLimit: cameraHeightBounds))
        
        let platerBounds = self.calculateAccumulatedFrame().width / 2
        let playerConstraint = SKConstraint.positionX(.init(lowerLimit: -platerBounds, upperLimit: platerBounds))
        self.camera?.constraints = [cameraWidthConstraint, cameraHeightConstraint] 
        self.player.constraints = [playerConstraint]
        let comecar = SKAction.run {
            for _ in 1...3{
                self.ativaSpawn()
            }
        }
        self.run(.sequence([.wait(forDuration: 2.0),comecar]))
        layerScenario.addChild(backgroundNode)
        backgroundNode.position = CGPoint(x: -screenWidth*0.5, y: -screenHeight*0.5)
        
        let goingRight = movingRightState()
        goingRight.gameScene = self
        let goingLeft = movingLeftState ()
        goingLeft.gameScene = self
        let idleR = isIdleRight()
        idleR.gameScene = self
        let idleL = isIdleLeft()
        idleL.gameScene = self
        let jumpR = jumpingRightState()
        jumpR.gameScene = self
        let jumpL = jumpingLeftState()
        jumpL.gameScene = self
        let deadR = isDeadRight()
        deadR.gameScene = self
        let deadL = isDeadLeft()
        deadL.gameScene = self
        let states = [goingLeft,goingRight, idleR, idleL, jumpL, jumpR, deadR, deadL]
        
        stateMachine = GKStateMachine (states: states)
        
        stateMachine?.enter(isIdleRight.self)
        for family in UIFont.familyNames.sorted() {
            print("Family: \(family)")
            
            // 2
            let names = UIFont.fontNames(forFamilyName: family)
            for fontName in names {
                print("- \(fontName)")
            }
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        
    }
    func addEnemiesFromTileMap(){ }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let location = t.location(in: cameraPlayer)
            
            //MARK: Makes the "joystick" appear where the user touched if it`s on the left side of the screen
            if location.x < 0 {
                joystick.moveJoystickToTouch(newPosition: location)
                joystick.jPosition = t
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Takes the first touch if there is one
        guard let touch = touches.first else { return }
        // Saves the location of first touch
        let location = touch.location(in: cameraPlayer)
        
        // Checks if is on teh left side of the screen
        if location.x < 0{
            joystick.calculateDisplacement(touchLocation: location)
            player.isTurningLeft = joystick.displacement < 0 ? true : false
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            if t == joystick.jPosition{
                joystick.setDisplacement(value: 0)
                
            }
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            if t == joystick.jPosition {
                joystick.setDisplacement(value: 0)
                
            }
        }
    }
    //MARK: DidBegin
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask{
        case physicsCategory.player.rawValue | physicsCategory.platform.rawValue: // player e plataforma
            if player.physicsBody!.velocity.dy < 0 && !player.hasContact{
                player.goDown = false
            }
            player.hasContact = true
            player.jumps = 0
            
        case physicsCategory.player.rawValue | physicsCategory.nofallplatform.rawValue:  //player and nofallplatform
            player.hasContact = true
            player.jumps = 0
            
        case  physicsCategory.player.rawValue | physicsCategory.enemyBullet.rawValue: // player e disparo inimigo
            
            if contact.bodyA.node?.name == "player"{
                _ = contact.bodyA.node
                let enemyBullet = contact.bodyB.node
                player.tomouTiro()

                if !player.isImortal{
                    enemyBullet!.removeFromParent()
                    
                   // code that removes a lifenode
                    if player.vidas <= 0 {player.vidas = 0}
                    hudNode.lifeNodes[player.vidas].texture = SKTexture(imageNamed: "life-off")
                }
                print(player.vidas)
                if player.vidas == 0{
                    
                    let endgame = SKAction.run {
                        self.gameOver()
                        
                        
                        self.isPaused = true
                    }
                    self.run(.sequence([.wait(forDuration:0.8),.wait(forDuration:1) ,endgame]))
                    
                    
                    
                }
                
            } else{
                _ = contact.bodyB.node
                let enemyBullet = contact.bodyA.node
                
                if !player.isImortal{
                    enemyBullet!.removeFromParent()
                }
                player.tomouDano()
                if player.vidas == 0{
                    
                    let endgame = SKAction.run {
                        self.gameOver()
                        self.isPaused = true
                    }
                    self.run(.sequence([.wait(forDuration:0.8),.wait(forDuration:1), endgame]))
                }
                print(player.vidas)
            }
            
        case physicsCategory.enemy.rawValue | physicsCategory.playerBullet.rawValue: // inimigo e disparo do player
            print("player acertou o inimigo")
            var enemyBody:SKPhysicsBody
            var playerBullet:SKPhysicsBody
            
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
                enemyBody = contact.bodyA
                playerBullet = contact.bodyB
                
            } else{
                enemyBody = contact.bodyB
                playerBullet = contact.bodyA
                
            }
            
            playerBullet.node?.removeFromParent()
            
            
            for i in layerScenario.inimigosAR{
                if i.name == enemyBody.node?.name{
                    i.inimigoTomouDano()
                    if i.vidas == 0{
                        i.morreu()
                        if i == Chaser(){
                            layerScenario.hasChaser = false
                        }
                        layerScenario.inimigosAR.removeAll(where: {$0.name == i.name})
                        for _ in 1...2{
                            var j = Int.random(in: 1...5)
                            if j == lastUsedSpawn{
                                while j == lastUsedSpawn{
                                    j = Int.random(in: 1...5)
                                }
                            }else{
                                self.lastUsedSpawn = j
                            }
                            switch j{
                            case 1:
                                _ = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { [self] timer in
                                    self.layerScenario.InimigoSpawn1(target: self.player)
                                }
                            case 2:
                                _ = Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false) { [self] timer in
                                    self.layerScenario.InimigoSpawn2(target: self.player)
                                }
                            case 3:
                                _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [self] timer in
                                    self.layerScenario.InimigoSpawn3(target: self.player)
                                }
                            case 4:
                                _ = Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) { [self] timer in
                                    self.layerScenario.InimigoSpawn4(target: self.player)
                                }
                            case 5:
                                _ = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { [self] timer in
                                    self.layerScenario.InimigoSpawn5(target: self.player)
                                }
                            default:
                                print("caso não encontrado")
                            }
                        }
                    }
                }
            }
            
            
        case physicsCategory.player.rawValue | physicsCategory.enemy.rawValue: // player e inimigo
            player.encostouNoInimigo(direção: joystick.displacement)
            // code that removes a lifenode
             if player.vidas <= 0 {player.vidas = 0}
             hudNode.lifeNodes[player.vidas].texture = SKTexture(imageNamed: "life-off")
         
            if player.vidas == 0{
                
                let endgame = SKAction.run {
                    self.gameOver()
                    self.isPaused = true
                }
                self.run(.sequence([.wait(forDuration:0.8),.wait(forDuration:1), endgame]))
            }
            
        case physicsCategory.enemy.rawValue | physicsCategory.enemyBullet.rawValue:
            print("bala bateu no inimigo")
            
        default: // contato não corresponde a nenhum caso
            print("no functional contact")
        }
    }
    
    //MARK: DidEnd
    func didEnd(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask{
        case physicsCategory.player.rawValue | physicsCategory.platform.rawValue:// Player and platform collision
            if player.physicsBody!.velocity.dy != 0{
                
                player.hasContact = false
            }
            if player.physicsBody!.velocity.dy >= 0{
                player.goDown = false
            }
        case physicsCategory.player.rawValue | physicsCategory.nofallplatform.rawValue: //player and nofallplatform collision
            if player.physicsBody!.velocity.dy != 0{
              
                player.hasContact = false
            }
        default:
            print("no functional end contact")
        }
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        if joystick.displacement != 0{
            player.playerMove(displacement: joystick.displacement)
        }
        cameraPlayer.position = player.position
        
        if player.physicsBody?.velocity.dy != 0 && player.hasContact == false{
            player.jumps = 1
        }
        
        if let body = player.physicsBody {
            let dy = body.velocity.dy
            if dy > 0 {
                // Prevent collisions if the hero is jumping
                body.collisionBitMask = physicsCategory.player.rawValue
                
            } else if (dy < 0  && player.goDown) {
                body.collisionBitMask = physicsCategory.nofallplatform.rawValue
                print("GODOWN")
            }
            
            else {
                // Allow collisions if the hero is falling
                
                body.collisionBitMask |= physicsCategory.nofallplatform.rawValue | physicsCategory.platform.rawValue
           
            }
            
            
        }
        
        
        
        stateMachine?.update(deltaTime: 0.01)
        
        if !layerScenario.inimigosAR.isEmpty{
            for enemie in layerScenario.inimigosAR{
                enemie.verificaTargetPosition()
            }
        }
        
        // MARK: This part is the In Game Timer
        if currentTime > hudNode.renderTime {
            if hudNode.renderTime > 0 {
                hudNode.seconds += 1
                if hudNode.seconds == 60 {
                    hudNode.seconds = 0
                    hudNode.minutes += 1
                }
                
                let secondsText = (hudNode.seconds < 10) ? "0\(hudNode.seconds)" : "\(hudNode.seconds)"
                let minutesText = (hudNode.minutes < 10) ? "0\(hudNode.minutes)" : "\(hudNode.minutes)"
                hudNode.timerLabel.text = "\(minutesText) : \(secondsText)"
                
                timerInSeconds += 1
                layerScenario.tempoAtual = timerInSeconds
                
                // let highscore saves the highscore by using UserDefaults
                let highscore = UserDefaults.standard.integer(forKey: easeScoreKey)
                if timerInSeconds > highscore {
                    UserDefaults.standard.set(timerInSeconds, forKey: easeScoreKey)
                }
                
            }
            hudNode.renderTime = currentTime + hudNode.changeTime
        }
        
        if hudNode.gamePaused == true {
            scene?.isPaused = true
            hudNode.seconds = hudNode.seconds - 1
        }

        
        let savedMusic: Bool = (UserDefaults.standard.integer(forKey: "MusicKey") != 0)
        if !savedMusic{
            backgroundMusic.run(SKAction.stop())
        }
    }
    
}



// MARK: - GameOver
extension GameScene {
    
    /// Function that format timeInSeconds to a custom string
    func formatTime(timerInSeconds: Int) -> String {
        let minutos = timerInSeconds / 60
        let segundos = timerInSeconds % 60
        
        // Format seconds and minutes to mm/ss
        let segundosFormatados = segundos < 10 ? "0\(segundos)" : "\(segundos)"
        let minutosFormatados = minutos < 10 ? "0\(minutos)" : "\(minutos)"
        
        return "\(minutosFormatados):\(segundosFormatados)"
    }
    
    /// Function that executes multiples essential functions to end the gameplay
    private func gameOver() {
        
        // Compares the saved highscore and the gameplay total time
        var highscore = UserDefaults.standard.integer(forKey: easeScoreKey)
        if timerInSeconds > highscore {
            highscore = timerInSeconds
        }
        
        let formattedTime = formatTime(timerInSeconds: timerInSeconds)
        let formattedHighTime = formatTime(timerInSeconds: highscore)
        
        hudNode.setupGameOver(formattedTime, formattedHighTime)
        hudNode.timerLabel.removeFromParent()
        hudNode.gamePaused = true
        
    }
}


extension GameScene {
    
    /// executes multiple funcs to start the Forbidden Waters gameplay
    private func startGame() {
        hudNode.setupPauseNode()
        hudNode.setupInGameTimer()
        hudNode.setupLife()
        backgroundNode.setupBackgrounds()
    }
    
}

extension GameScene{
    private func ativaSpawn(){
        let numSpawn = Int.random(in: 1...5)

        switch numSpawn{
        case 1:
            layerScenario.InimigoSpawn1(target: self.player)
        case 2:
            layerScenario.InimigoSpawn2(target: self.player)
        case 3:
            layerScenario.InimigoSpawn3(target: self.player)
        case 4:
            layerScenario.InimigoSpawn4(target: self.player)
        case 5:
            layerScenario.InimigoSpawn5(target: self.player)
        default:
            print("spawn não encontrado")
        }
    }
}


