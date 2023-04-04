//
//  GameScene.swift
//  Pongoal
//
//  Created by Nik Cadez on 18/12/2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball : GameBall!
    var player : GamePug!
    var opponent : GamePug!
    var wall : GameWall!
    var oponent_goal = SKSpriteNode()
    var player_goal = SKSpriteNode()
    var player_score = Int()
    var player_score_d = SKSpriteNode()
    var opponent_score = Int()
    var opponent_score_d = SKSpriteNode()
    var currState : GameState?
    var BasicUi : GameBasicUI!
    var soundManager: SoundManager!
    var peerPopUp: SKSpriteNode!
    var celebration: SKSpriteNode!
    var maxScore: Int!
    
    let animation = SKAction.animate(with: [
        SKTexture(imageNamed: "dust0"),
        SKTexture(imageNamed: "dust1"),
        SKTexture(imageNamed: "dust2"),
        SKTexture(imageNamed: "dust3"),
        SKTexture(imageNamed: "dust4"),
        SKTexture(imageNamed: "dust5")
    ], timePerFrame: 0.05)

    
    
    override func sceneDidLoad() {
        
        // set game state to will start
        currState = GameState.start
        self.maxScore = 9
        self.maxScore = self.maxScore - 1
        
        // init all nodes
        ball = GameBall(node: self.childNode(withName: "ball") as! SKSpriteNode)
        player = GamePug(node: self.childNode(withName: "player") as! SKSpriteNode, type: "player")
        opponent = GamePug(node: self.childNode(withName: "opponent") as! SKSpriteNode, type: "opponent")
        wall = GameWall(node: self.childNode(withName: "wall")!)
        oponent_goal = self.childNode(withName: "score_o") as! SKSpriteNode
        player_goal = self.childNode(withName: "score_p") as! SKSpriteNode
        BasicUi = GameBasicUI(node: self.childNode(withName: "title") as! SKSpriteNode)
        player_score_d = self.childNode(withName: "d_score_p") as! SKSpriteNode
        opponent_score_d = self.childNode(withName: "d_score_o") as! SKSpriteNode
        player_score = 0
        opponent_score = 0
        
        soundManager = SoundManager()
        soundManager.music.play()
        
        //physicsWorld
        physicsWorld.contactDelegate = self
        
        // set category bitmask
        oponent_goal.physicsBody?.categoryBitMask = ContactModel.goal_opponent
        player_goal.physicsBody?.categoryBitMask = ContactModel.goal_player
        
        BasicUi.loadMainMenu()
        
        celebration = SKSpriteNode(imageNamed: "text_goal")
        celebration.zPosition = 16
        celebration.isHidden = true
        self.addChild(celebration)
        
        
    }
    
    func celebrateGoal() {
        soundManager.playSiren()
        celebration.setScale(0)
        let act0 = SKAction.unhide()
        let act1 = SKAction.scale(to: 1, duration: 1)
        let act2 = SKAction.hide()
        let seq = SKAction.sequence([act0, act1, act2])
        celebration.run(seq)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch(currState) {
        case .start:
            for touch in touches {
                let location = touch.location(in: self)
                BasicUi.touchBeginHandle(loc: location)
                soundManager.playClick()
            }
        case .inMenu:
            for touch in touches {
                let location = touch.location(in: self)
                BasicUi.touchBeginHandle(loc: location)
                soundManager.playClick()
            }
            break
        case .isRunning:
            for touch in touches {
                let location = touch.location(in: self)
                player.spriteNode.position.x = location.x
                
                // open menu if middle ofscreen is pressed
                if abs(location.x) < 40 && abs(location.y) < 40 {
                    currState = .inMenu
                    ball.saveBallVelocity(state: ball.spriteNode.physicsBody!.velocity)
                    ball.restartVelocity()
                    BasicUi.loadPauseMenu()
                }
                if (checkIfIn(node: opponent.spriteNode, loc: location)) {
                    ball.smokeScreen()
                    opponent.blind()
                }
            }
            break
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch(currState) {
        case .start:
            for touch in touches {
                let location = touch.location(in: self)
                let action = BasicUi.touchEndHandle(loc: location)
                switch(action) {
                case "start":
                    ball.start()
                    BasicUi.ResetNode()
                    currState = .isRunning
                    break
                case "restart":
                    currState = GameState.isRunning
                    BasicUi.ResetNode()
                    ball.restartPosition()
                    ball.randomVelocity()
                    player_score = 0
                    opponent_score = 0
                    self.setPlayerOponentScore()
                    break
                case "easy":
                    opponent.agent?.setState(state: action)
                    break
                case "medium":
                    opponent.agent?.setState(state: action)
                    break
                case "hard":
                    opponent.agent?.setState(state: action)
                    break
                case "impossible":
                    opponent.agent?.setState(state: action)
                    break
                default:
                    break
                }
                soundManager.volumeEdit()
            }
            break
        case .inMenu:
            for touch in touches {
                let location = touch.location(in: self)
                let action = BasicUi.touchEndHandle(loc: location)
                switch(action) {
                case "continue":
                    currState = GameState.isRunning
                    BasicUi.ResetNode()
                    ball.resumeBall()
                    break
                case "restart":
                    currState = GameState.isRunning
                    BasicUi.ResetNode()
                    ball.restartPosition()
                    ball.randomVelocity()
                    player_score = 0
                    opponent_score = 0
                    self.setPlayerOponentScore()
                    break
                case "start":
                    currState = GameState.isRunning
                    BasicUi.ResetNode()
                    ball.restartPosition()
                    ball.randomVelocity()
                    player_score = 0
                    opponent_score = 0
                    self.setPlayerOponentScore()
                    break
                case "easy":
                    opponent.agent?.setState(state: action)
                    break
                case "medium":
                    opponent.agent?.setState(state: action)
                    break
                case "hard":
                    opponent.agent?.setState(state: action)
                    break
                case "impossible":
                    opponent.agent?.setState(state: action)
                    break
                default:
                    break
                }
                soundManager.volumeEdit()
            }
            break
        default:
            break
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch(currState) {
        case .start:
            for touch in touches {
                let location = touch.location(in: self)
                BasicUi.touchMoveHandle(loc: location)
            }
            break
        case .inMenu:
            for touch in touches {
                let location = touch.location(in: self)
                BasicUi.touchMoveHandle(loc: location)
            }
            break
        case .isRunning:
            for touch in touches {
                player.moveViaTouch(location: touch.location(in: self))
            }
        default:
            break
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // oponent moving
        opponent.moveViaAgent(Ball: ball.spriteNode)

    }
    
    override func didSimulatePhysics() {
        ball.rotateBall()
        if(ball.restart) {
            ball.restart = false
            ball.restartPosition()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        if (bodyA.categoryBitMask==ContactModel.goal_player) {
            player_score+=1
            ball.restart = true
            ball.randomVelocity()
            setPlayerOponentScore()
            
            //ending the game
            if (player_score > self.maxScore) {
                // game will end player has won
                UserDefaults.standard.set(true, forKey: BasicUi.mainMenu.getProfessor())
                BasicUi.youWin()
                ball.restartVelocity()
                ball.restart = true
                currState = GameState.inMenu
                soundManager.playSiren()
            } else {
                celebrateGoal()
            }
            
        } else
        if (bodyA.categoryBitMask==ContactModel.goal_opponent) {
            opponent_score+=1
            ball.restart = true
            ball.randomVelocity()
            setPlayerOponentScore()
            
            // ending the game
            if (opponent_score > self.maxScore) {
                // game will end oponent has won
                BasicUi.youLose()
                ball.restartVelocity()
                ball.restart = true
                currState = GameState.inMenu
                soundManager.playSiren()
            } else {
                celebrateGoal()
            }
        } else
        if (bodyA.categoryBitMask==ContactModel.player) {
            soundManager.playBounce()
            player.runAnimation()
            ball.spriteNode.physicsBody?.velocity.dx = 0
            ball.spriteNode.physicsBody?.velocity.dy = CGFloat(player.power)
            ball.spriteNode.physicsBody?.applyImpulse(calculateImpuse(node: player.spriteNode))

        } else
        if (bodyA.categoryBitMask==ContactModel.opponent) {
            soundManager.playBounce()
            opponent.runAnimation()
            ball.spriteNode.physicsBody?.velocity.dx = 0
            ball.spriteNode.physicsBody?.velocity.dy = CGFloat(opponent.power)
            ball.spriteNode.physicsBody?.applyImpulse(calculateImpuse(node: opponent.spriteNode))
        } else {
            soundManager.playHit()
            createCloud(ball: ball.spriteNode)
        }
        
        
    }
    
    func calculateImpuse(node: SKSpriteNode) -> CGVector {
        let ballX = ball.spriteNode.position.x
        let playerX = node.position.x
        return CGVector(dx:-(playerX - ballX) / 2, dy: 0)
    }
    
    func setPlayerOponentScore() {
        player_score_d.texture = SKTexture(imageNamed: "numbers/\(player_score)")
        opponent_score_d.texture = SKTexture(imageNamed: "numbers/\(opponent_score)")
    }
    func createCloud(ball: SKSpriteNode) {

        let cloud = SKSpriteNode(imageNamed: "dust0")
        self.addChild(cloud)
        let remove = SKAction.removeFromParent()
        cloud.position = ball.position
        cloud.zPosition = 5
        cloud.isHidden = false
        let seq = SKAction.sequence([animation, remove])
        cloud.run(seq)
    }
    
    func checkIfIn(node:SKSpriteNode, loc:CGPoint) -> Bool {
        if (node.position.x - node.size.width/2 < loc.x &&
            node.position.x + node.size.width/2 > loc.x)
            
            &&
            
            (node.position.y - node.size.height/2 < loc.y &&
             node.position.y + node.size.height/2 > loc.y) {
            
            return true
        }
        return false
    }
}
