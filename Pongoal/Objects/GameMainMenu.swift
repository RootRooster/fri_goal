//
//  GameMainMenu.swift
//  Pongoal
//
//  Created by Nik Cadez on 30/01/2023.
//

import Foundation
import SpriteKit

enum menu {
    case main, none, diff, sound
}

class GameMainMenu:GameObject {
    
    // main menu
    var size: CGSize
    
    var spriteNode: SKSpriteNode
    var wood: SKSpriteNode
    
    var playButton: SKSpriteNode
    var playText: SKSpriteNode
    
    var soundButton: SKSpriteNode
    var soundText: SKSpriteNode
    
    var difficultyButton: SKSpriteNode
    var difficultyText: SKSpriteNode
    
    var startPressed: Bool
    var soundPressed: Bool
    var difficultyPressed: Bool
    
    var menu:menu
    
    
    // sound settings
    var sliderVolumeNode1: SKSpriteNode
    var sliderVolumeNode2: SKSpriteNode
    var buttonSlider1: SKSpriteNode
    var buttonSlider2: SKSpriteNode
    var grabSlider1: Bool
    var grabSlider2: Bool
    var okButton: SKSpriteNode
    var okBtnPress: Bool
    var soundText2: SKSpriteNode
    var soundFXText: SKSpriteNode
    var board: SKSpriteNode
    
    // diff settings
    var buttonLeft : SKSpriteNode
    var buttonRight : SKSpriteNode
    var mode: SKSpriteNode
    var boss: SKSpriteNode
    var leftClick: Bool
    var rightClick: Bool
    var stateClick: Int
//    var chatBubble: SKSpriteNode
    
    init(spriteNode: SKSpriteNode) {
        self.spriteNode = spriteNode
        self.size = spriteNode.size
        
        spriteNode.removeAllChildren()
        spriteNode.position.y = 500
        menu = .main
        
        wood = SKSpriteNode(imageNamed: "board_vertical")
        wood.size.width = wood.size.width + 100
        wood.position.y = 250
        wood.zPosition = -1
        
        // main menu
        let playPosY = CGFloat(-300)
        let offset = CGFloat(80)
        playButton = SKSpriteNode(imageNamed: "playLong0")
        playButton.zPosition = 1
        playButton.position.y = playPosY
        playText = SKSpriteNode(imageNamed: "startGame")
        playText.zPosition = 2
        playText.position.y = playPosY
        playText.position.x = playText.position.x + offset
        playText.setScale(0.2)
        
        let soundPosY = CGFloat(-500)
        soundButton = SKSpriteNode(imageNamed: "settingsLonger0")
        soundButton.zPosition = 1
        soundButton.position.y = soundPosY
        soundText = SKSpriteNode(imageNamed: "soundText")
        soundText.zPosition = 2
        soundText.position.y = soundPosY
        soundText.position.x = soundText.position.x + 30
        soundText.setScale(0.2)
        
        let difficultyPosY = CGFloat(-700)
        difficultyButton = SKSpriteNode(imageNamed: "settingsLonger0")
        difficultyButton.zPosition = 1
        difficultyButton.position.y = difficultyPosY
        difficultyText = SKSpriteNode(imageNamed: "diffText")
        difficultyText.zPosition = 2
        difficultyText.position.y = difficultyPosY
        difficultyText.position.x = difficultyText.position.x + offset - 10
        difficultyText.setScale(0.2)
        
        startPressed = false
        soundPressed = false
        difficultyPressed = false
        
        // settings menu - sound
        sliderVolumeNode1 = SKSpriteNode(imageNamed: "slider_bg")
        sliderVolumeNode1.zPosition = 2
        sliderVolumeNode1.size = CGSize(width: 500, height: 150)
        sliderVolumeNode1.position.y = -730
        
        sliderVolumeNode2 = SKSpriteNode(imageNamed: "slider_bg")
        sliderVolumeNode2.zPosition = 2
        sliderVolumeNode2.size = CGSize(width: 500, height: 150)
        sliderVolumeNode2.position.y = -470
        
        buttonSlider1 = SKSpriteNode(imageNamed: "greenLight0")
        buttonSlider1.zPosition = 3
        grabSlider1 = false
        sliderVolumeNode1.addChild(buttonSlider1)
        
        buttonSlider2 = SKSpriteNode(imageNamed: "greenLight0")
        buttonSlider2.zPosition = 3
        grabSlider2 = false
        sliderVolumeNode2.addChild(buttonSlider2)
        
        okButton = SKSpriteNode(imageNamed: "ok0")
        okButton.zPosition = 3
        okBtnPress = false
        okButton.position.y = -900
        
        
        soundText2 = SKSpriteNode(imageNamed: "soundText")
        soundText2.setScale(0.4)
        soundText2.position.y = -350
        soundText2.zPosition = 3
        
        soundFXText = SKSpriteNode(imageNamed: "soundFXtext")
        soundFXText.setScale(0.25)
        soundFXText.position.y = -600
        soundFXText.zPosition = 3
        
        board = SKSpriteNode(imageNamed: "board_vertical")
        board.zPosition = 1
        board.position.y = -600
        
        // diff settings
        let setPos = CGFloat(-750)
        let setAbsX = CGFloat(200)
        
        buttonLeft = SKSpriteNode(imageNamed: "next0")
        buttonLeft.zPosition = 3
        buttonLeft.zRotation = .pi
        buttonLeft.position.y = setPos
        buttonLeft.position.x = -setAbsX
        leftClick = false
        
        buttonRight = SKSpriteNode(imageNamed: "next0")
        buttonRight.zPosition = 3
        buttonRight.position.y = setPos
        buttonRight.position.x = setAbsX
        rightClick = false
        
        mode = SKSpriteNode(imageNamed: "medium")
        mode.zPosition = 3
        mode.position.y = setPos
        mode.setScale(0.25)
        
        boss = SKSpriteNode(imageNamed: "normal")
        boss.zPosition = 3
        boss.setScale(0.15)
        boss.position.y = -450
//        chatBubble = SKSpriteNode(imageNamed: "chat")
//        chatBubble.zPosition = 5
//        chatBubble.position.y = 1500
//        chatBubble.position.x = -1500
        
        stateClick = 0
        
    }
    
    func loadSelf() {
        unhide()
        menu = .main
        spriteNode.removeAllChildren()
        spriteNode.position.y = 500
        spriteNode.texture = SKTexture(imageNamed: "title")
        spriteNode.size = self.size
        spriteNode.addChild(wood)
        
        spriteNode.addChild(playText)
        spriteNode.addChild(playButton)
        
        spriteNode.addChild(soundButton)
        spriteNode.addChild(soundText)
        
        spriteNode.addChild(difficultyText)
        spriteNode.addChild(difficultyButton)
    }
    
    func loadSound() {
        menu = .sound
        if let point = UserDefaults.standard.object(forKey: "slider1") as? CGFloat {
            buttonSlider1.position.x = point
        }
        if let point = UserDefaults.standard.object(forKey: "slider2") as? CGFloat {
            buttonSlider2.position.x = point
        }
        spriteNode.removeAllChildren()
        spriteNode.addChild(sliderVolumeNode1)
        spriteNode.addChild(sliderVolumeNode2)
        spriteNode.addChild(wood)
        spriteNode.addChild(board)
        spriteNode.addChild(soundText2)
        spriteNode.addChild(soundFXText)
        spriteNode.addChild(okButton)
        
    }
    func loadDiff() {
        menu = .diff
        spriteNode.removeAllChildren()
        
        setBossAndMode()
        
        spriteNode.addChild(wood)
        spriteNode.addChild(board)
        spriteNode.addChild(okButton)
        spriteNode.addChild(boss)
        spriteNode.addChild(buttonLeft)
        spriteNode.addChild(buttonRight)
        spriteNode.addChild(mode)
    }
    
    func setBossAndMode() {
        if let md = UserDefaults.standard.object(forKey: "diff") as? String {
            mode.texture = SKTexture(imageNamed: md)
            switch (md) {
            case "easy":
                stateClick = 1
                bosTexture(name:"klemenc")
                //chat_animation(boss:boss)
                break
            case "medium":
                stateClick = 2
                bosTexture(name:"normal")
                //chat_animation(boss:boss)
                break
            case "hard":
                stateClick = 3
                bosTexture(name:"peer")
                //chat_animation(boss:boss)
                break
            case "impossible":
                stateClick = 4
                bosTexture(name:"kononenko")
                //chat_animation(boss:boss)
                break
            default:
                break
            }
        }
    }
    
    func setBossAndMode(number: Int) {
        switch (number) {
        case 1:
            stateClick = 1
            mode.texture = SKTexture(imageNamed: "easy")
            bosTexture(name:"klemenc")
            //chat_animation(boss:boss)
            break
        case 2:
            stateClick = 2
            mode.texture = SKTexture(imageNamed: "medium")
            bosTexture(name:"normal")
            //chat_animation(boss:boss)
            break
        case 3:
            stateClick = 3
            mode.texture = SKTexture(imageNamed: "hard")
            bosTexture(name:"peer")
            //chat_animation(boss:boss)
            break
        case 4:
            stateClick = 4
            mode.texture = SKTexture(imageNamed: "impossible")
            bosTexture(name:"kononenko")
            //chat_animation(boss:boss)
            break
        default:
            break
        }
    }
    
    func bosTexture(name:String) {
        if UserDefaults.standard.object(forKey: name) is Bool {
            let nameD = name + "D"
            boss.texture = SKTexture(imageNamed: nameD)
        } else {
            boss.texture = SKTexture(imageNamed: name)
        }
    }
    
//    func getChatFromState()->String {
//        switch(stateClick) {
//        case 1:
//            return "chatKlemenc0"
//        case 2:
//            return "chatNormal0"
//        case 3:
//            return "chatPeer0"
//        case 4:
//            return "chatKononenko0"
//        default:
//            return "chat"
//
//        }
//    }
    
    func getProfessor() -> String {
        switch(stateClick) {
        case 1:
            return "klemenc"
        case 2:
            return "normal"
        case 3:
            return "peer"
        case 4:
            return "kononenko"
        default:
            return "cheat"
            
        }
    }
    
//    func chat_animation(boss: SKSpriteNode) {
//        chatBubble.texture = SKTexture(imageNamed: getChatFromState())
//        chatBubble.removeFromParent()
//        boss.removeAllActions()
//        boss.run(SKAction.sequence([SKAction.run {
//            boss.addChild(self.chatBubble)
//        }, SKAction.wait(forDuration: 15),SKAction.run {
//            boss.removeAllChildren()
//        }]))
//    }
    
    func handleTouchBegin(loc: CGPoint) {
        let corrLoc = CGPoint(x: loc.x, y: loc.y - 500)
        switch(self.menu) {
        case .main:
            if (checkIfIn(node: playButton, loc: corrLoc)) {
                playButton.texture = SKTexture(imageNamed: "playLong1")
                startPressed = true
            } else
            if (checkIfIn(node: difficultyButton, loc: corrLoc)) {
                difficultyButton.texture = SKTexture(imageNamed: "settingsLonger1")
                difficultyPressed = true
            } else
            if (checkIfIn(node: soundButton, loc: corrLoc)) {
                soundButton.texture = SKTexture(imageNamed: "settingsLonger1")
                soundPressed = true
            }
            break
        case .diff:
            if (checkIfIn(node: buttonLeft, loc: corrLoc) && stateClick > 1) {
                leftClick = true
                buttonLeft.texture = SKTexture(imageNamed: "next1")
                
            }
            if (checkIfIn(node: buttonRight, loc: corrLoc) && stateClick < 4) {
                rightClick = true
                buttonRight.texture = SKTexture(imageNamed: "next1")
                
            }
            if(checkIfIn(node: okButton, loc: corrLoc)) {
                okBtnPress = true
                //chatBubble.removeFromParent()
                boss.removeAllActions()
                okButton.texture = SKTexture(imageNamed: "ok1")
            }
            break
        case .none:
            break
        case .sound:
            if(checkIfIn(node: okButton, loc: corrLoc)) {
                okBtnPress = true
                okButton.texture = SKTexture(imageNamed: "ok1")
            }
            if checkIfIn(node: sliderVolumeNode1, loc: corrLoc) {
                buttonSlider1.texture = SKTexture(imageNamed: "greenLight1")
                grabSlider1 = true
            }
            if checkIfIn(node: sliderVolumeNode2, loc: corrLoc) {
                buttonSlider2.texture = SKTexture(imageNamed: "greenLight1")
                grabSlider2 = true
            }
            break
        }
    }
    
    func handleTouchMoved(loc: CGPoint) {
        let corrLoc = CGPoint(x: loc.x, y: loc.y - 500)
        switch(self.menu) {
        case .main:
            break
        case .diff:
            break
        case .none:
            break
        case .sound:
            if grabSlider1 {
                if  (corrLoc.x < 150 && corrLoc.x > -125) {
                    buttonSlider1.position.x = corrLoc.x
                } else if (corrLoc.x > 150) {
                    buttonSlider1.position.x = 150
                } else if (corrLoc.x < -125) {
                    buttonSlider1.position.x = -125
                }
            }
            if grabSlider2 {
                if  (corrLoc.x < 150 && corrLoc.x > -125) {
                    buttonSlider2.position.x = corrLoc.x
                } else if (corrLoc.x > 150) {
                    buttonSlider2.position.x = 150
                } else if (corrLoc.x < -125) {
                    buttonSlider2.position.x = -125
                }
            }
            break
        }
    }
    
    func returnWantedState() -> String {
        switch(stateClick) {
        case 1:
            return "easy"
        case 2:
            return "medium"
        case 3:
            return "hard"
        case 4:
            return "impossible"
        default:
            return "medium"
        }
    }
    
    func handleTouchEnd(loc: CGPoint) -> String {
        switch(self.menu) {
        case .main:
            if startPressed {
                playButton.texture = SKTexture(imageNamed: "playLong0")
                startPressed = false
                return "start"
            }
            if difficultyPressed {
                difficultyButton.texture = SKTexture(imageNamed: "settingsLonger0")
                difficultyPressed = false
                loadDiff()
            }
            if soundPressed {
                soundButton.texture = SKTexture(imageNamed: "settingsLonger0")
                soundPressed = false
                loadSound()
            }
            return "none"
        case .diff:
            if rightClick {
                rightClick = false
                stateClick += 1
                buttonRight.texture = SKTexture(imageNamed: "next0")
                setBossAndMode(number: stateClick)
                return returnWantedState()
            }
            if leftClick {
                leftClick = false
                stateClick -= 1
                buttonLeft.texture = SKTexture(imageNamed: "next0")
                setBossAndMode(number: stateClick)
                return returnWantedState()
            }
            if okBtnPress {
                okBtnPress = false
                okButton.texture = SKTexture(imageNamed: "ok0")
                loadSelf()
            }
            return "none"
        case .none:
            return "none"
        case .sound:
            if okBtnPress {
                okBtnPress = false
                okButton.texture = SKTexture(imageNamed: "ok0")
                loadSelf()
            }
            if grabSlider1 {
                UserDefaults.standard.set(buttonSlider1.position.x, forKey: "slider1")
                buttonSlider1.texture = SKTexture(imageNamed: "greenLight0")
                grabSlider1 = false
                
            }
            if grabSlider2 {
                UserDefaults.standard.set(buttonSlider2.position.x, forKey: "slider2")
                buttonSlider2.texture = SKTexture(imageNamed: "greenLight0")
                grabSlider2 = false
                
            }
            return "none"
        }
    }
    
    func hide() {
        self.spriteNode.isHidden = true
    }
    
    func unhide() {
        spriteNode.isHidden = false
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
