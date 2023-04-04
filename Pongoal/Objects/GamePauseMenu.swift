//
//  GamePauseMenu.swift
//  Pongoal
//
//  Created by Nik Cadez on 02/01/2023.
//

import Foundation
import SpriteKit

enum SubMenu {
    case main,settings
}

class GamePauseMenu:GameObject {
    var spriteNode: SKSpriteNode
    var continueNode: SKSpriteNode
    var restartNode: SKSpriteNode
    var settingsNode: SKSpriteNode
    var sliderVolumeNode1: SKSpriteNode
    var sliderVolumeNode2: SKSpriteNode
    var homeNode: SKSpriteNode
    var titleHolder: SKSpriteNode
    var text: SKSpriteNode
    var buttonSlider1: SKSpriteNode
    var buttonSlider2: SKSpriteNode
    var subMenu: SubMenu
    var grabSlider1: Bool
    var grabSlider2: Bool
    var okButton: SKSpriteNode
    var okBtnPress: Bool
    var winNode: SKSpriteNode
    var loseNode: SKSpriteNode
    var musicText: SKSpriteNode
    var soundSFText: SKSpriteNode
    var isLoadSettins: Bool
    var isLoadMain: Bool
    var end: Bool
    var continuePressed: Bool
    
    
    func hide() {
        spriteNode.isHidden = true
    }
    
    func unhide() {
        spriteNode.isHidden = false
    }
    
    func initAll() {
        continueNode = SKSpriteNode(imageNamed: "continue0")
        continueNode.zPosition = 5
        continueNode.position.y = CGFloat(-200)
        
        restartNode = SKSpriteNode(imageNamed: "repeat0")
        restartNode.zPosition = 5
        restartNode.position.x = CGFloat(-200)
        
        settingsNode = SKSpriteNode(imageNamed: "settings0")
        settingsNode.zPosition = 5
        settingsNode.position.x = CGFloat(200)
        
        homeNode = SKSpriteNode(imageNamed: "home0")
        homeNode.zPosition = 5
        
        titleHolder = SKSpriteNode(imageNamed: "board_header")
        titleHolder.zPosition = 5
        titleHolder.position.y = CGFloat(200)
        
        text = SKSpriteNode(imageNamed: "pauseText")
        text.zPosition = 6
        text.setScale(0.3)
        text.position.y = CGFloat(195)
        
        sliderVolumeNode1 = SKSpriteNode(imageNamed: "slider_bg")
        sliderVolumeNode1.zPosition = 5
        sliderVolumeNode1.size = CGSize(width: 500, height: 150)
        
        sliderVolumeNode2 = SKSpriteNode(imageNamed: "slider_bg")
        sliderVolumeNode2.zPosition = 5
        sliderVolumeNode2.size = CGSize(width: 500, height: 150)
        
        buttonSlider1 = SKSpriteNode(imageNamed: "greenLight0")
        buttonSlider1.zPosition = 6
        grabSlider1 = false
        
        buttonSlider2 = SKSpriteNode(imageNamed: "greenLight0")
        buttonSlider2.zPosition = 6
        grabSlider2 = false
        
        okButton = SKSpriteNode(imageNamed: "ok0")
        okButton.zPosition = 6
        okBtnPress = false
        
        musicText = SKSpriteNode(imageNamed: "soundText")
        musicText.setScale(0.4)
        musicText.position.y = 250
        musicText.zPosition = 6
        
        soundSFText = SKSpriteNode(imageNamed: "soundFXtext")
        soundSFText.setScale(0.25)
        soundSFText.position.y = -30
        soundSFText.zPosition = 6
        
        continuePressed = false
        
    }
    
    init(node: SKSpriteNode) {
        self.subMenu = .main
        
        spriteNode = node
        
        isLoadSettins = false
        isLoadMain = false
        
        continueNode = SKSpriteNode(imageNamed: "continue0")
        continueNode.zPosition = 5
        continueNode.position.y = CGFloat(-200)
        
        restartNode = SKSpriteNode(imageNamed: "repeat0")
        restartNode.zPosition = 5
        restartNode.position.x = CGFloat(-200)
        
        settingsNode = SKSpriteNode(imageNamed: "settings0")
        settingsNode.zPosition = 5
        settingsNode.position.x = CGFloat(200)
        
        homeNode = SKSpriteNode(imageNamed: "home0")
        homeNode.zPosition = 5
        
        titleHolder = SKSpriteNode(imageNamed: "board_header")
        titleHolder.zPosition = 5
        titleHolder.position.y = CGFloat(200)
        
        winNode = SKSpriteNode(imageNamed: "text_win")
        winNode.zPosition = 5
        winNode.setScale(0.7)
        winNode.position.y = CGFloat(200)
        
        loseNode = SKSpriteNode(imageNamed: "text_lose")
        loseNode.zPosition = 5
        loseNode.setScale(0.7)
        loseNode.position.y = CGFloat(200)
        
        text = SKSpriteNode(imageNamed: "pauseText")
        text.zPosition = 6
        text.setScale(0.3)
        text.position.y = CGFloat(195)
        
        sliderVolumeNode1 = SKSpriteNode(imageNamed: "slider_bg")
        sliderVolumeNode1.zPosition = 5
        sliderVolumeNode1.size = CGSize(width: 500, height: 150)
        
        sliderVolumeNode2 = SKSpriteNode(imageNamed: "slider_bg")
        sliderVolumeNode2.zPosition = 5
        sliderVolumeNode2.size = CGSize(width: 500, height: 150)
        
        buttonSlider1 = SKSpriteNode(imageNamed: "greenLight0")
        buttonSlider1.zPosition = 6
        grabSlider1 = false
        
        buttonSlider2 = SKSpriteNode(imageNamed: "greenLight0")
        buttonSlider2.zPosition = 6
        grabSlider2 = false
        
        okButton = SKSpriteNode(imageNamed: "ok0")
        okButton.zPosition = 6
        okBtnPress = false
        
        musicText = SKSpriteNode(imageNamed: "soundText")
        musicText.setScale(0.7)
        musicText.zPosition = 6
        
        soundSFText = SKSpriteNode(imageNamed: "soundFXtext")
        soundSFText.setScale(0.7)
        soundSFText.zPosition = 6
        
        end = false
        continuePressed = false
    }
    
    func loadSelf() {
        
        initAll()
        
        // texture load an adding children
        spriteNode.removeAllChildren()
        subMenu = .main
        spriteNode.texture = SKTexture(imageNamed: "board_vertical")
        spriteNode.position = CGPoint()
        spriteNode.size.height = 800
        spriteNode.size.width = 650
        if (!end) {
            spriteNode.addChild(continueNode)
        }
        spriteNode.addChild(restartNode)
        spriteNode.addChild(homeNode)
        spriteNode.addChild(settingsNode)
        spriteNode.addChild(titleHolder)
        spriteNode.addChild(text)
        unhide()
    }
    
    func loadWin() {
        initAll()
        subMenu = .main
        spriteNode.removeAllChildren()
        spriteNode.texture = SKTexture(imageNamed: "board_vertical")
        spriteNode.position = CGPoint()
        spriteNode.size.height = 800
        spriteNode.size.width = 650
        spriteNode.addChild(restartNode)
        spriteNode.addChild(homeNode)
        spriteNode.addChild(settingsNode)
        spriteNode.addChild(winNode)
        end = true
        unhide()
     // TODO: this
    }
    func loadLose() {
        initAll()
        subMenu = .main
        spriteNode.removeAllChildren()
        spriteNode.texture = SKTexture(imageNamed: "board_vertical")
        spriteNode.position = CGPoint()
        spriteNode.size.height = 800
        spriteNode.size.width = 650
        spriteNode.addChild(restartNode)
        spriteNode.addChild(homeNode)
        spriteNode.addChild(settingsNode)
        spriteNode.addChild(loseNode)
        end = true
        unhide()
     // TODO: this
    }
    
    func loadSettings() {
        spriteNode.removeAllChildren()
        sliderVolumeNode2.position.y = 150
        sliderVolumeNode1.position.y = -130
        okButton.position.y = -300
        sliderVolumeNode1.addChild(buttonSlider1)
        sliderVolumeNode2.addChild(buttonSlider2)
        if let point = UserDefaults.standard.object(forKey: "slider1") as? CGFloat {
            buttonSlider1.position.x = point
        }
        if let point = UserDefaults.standard.object(forKey: "slider2") as? CGFloat {
            buttonSlider2.position.x = point
        }
        spriteNode.addChild(sliderVolumeNode1)
        spriteNode.addChild(sliderVolumeNode2)
        spriteNode.addChild(okButton)
        spriteNode.addChild(soundSFText)
        spriteNode.addChild(musicText)
        okBtnPress = false
    }
    
    func handleTouchBegin(loc: CGPoint) {
        switch(subMenu) {
        case .main:
            if (checkIfIn(node: continueNode, loc: loc) && (end != true)) {
                continuePressed = true
                continueNode.texture = SKTexture(imageNamed: "continue1")
                end = false
            } else
            if (checkIfIn(node: restartNode, loc: loc)) {
                restartNode.texture = SKTexture(imageNamed: "repeat1")
                end = false
            } else
            if (checkIfIn(node: settingsNode, loc: loc)) {
                isLoadSettins = true
                settingsNode.texture = SKTexture(imageNamed: "settings1")
            } else
            if (checkIfIn(node: homeNode, loc: loc)) {
                homeNode.texture = SKTexture(imageNamed: "home1")
                isLoadMain = true
                end = false
            }
            break
            
        case .settings:
            if (checkIfIn(node: sliderVolumeNode1, loc: loc)) {
                grabSlider1 = true
                buttonSlider1.texture = SKTexture(imageNamed: "greenLight1")
            }
            if (checkIfIn(node: sliderVolumeNode2, loc: loc)) {
                grabSlider2 = true
                buttonSlider2.texture = SKTexture(imageNamed: "greenLight1")
            }
            if (checkIfIn(node: okButton, loc: loc)) {
                okButton.texture = SKTexture(imageNamed: "ok1")
                okBtnPress = true
            }
            break
        }
    }
    
    func handleTouchMove(loc:CGPoint) {
        switch(subMenu) {
        case .main:
            break
            
        case .settings:
            if grabSlider1 {
                if  (loc.x < 150 && loc.x > -125) {
                    buttonSlider1.position.x = loc.x
                } else if (loc.x > 150) {
                    buttonSlider1.position.x = 150
                } else if (loc.x < -125) {
                    buttonSlider1.position.x = -125
                }
            }
            if grabSlider2 {
                if  (loc.x < 150 && loc.x > -125) {
                    buttonSlider2.position.x = loc.x
                } else if (loc.x > 150) {
                    buttonSlider2.position.x = 150
                } else if (loc.x < -125) {
                    buttonSlider2.position.x = -125
                }
            }
            break
        }
        
    }
    
    func handleTouchEnd(loc: CGPoint) -> String {
        switch(subMenu) {
        case .main:
            if continuePressed {
                continuePressed = false
                return "continue"
            } else
            if (checkIfIn(node: restartNode, loc: loc)){
                return "restart"
            } else
            if isLoadSettins {
                isLoadSettins = false
                subMenu = .settings
                loadSettings()
            }else
            if isLoadMain {
                homeNode.texture = SKTexture(imageNamed: "home0")
                isLoadMain = false
                return "loadMain"
            }
            return "none"
            
        case .settings:
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
            if okBtnPress {
                okBtnPress = false
                okButton.texture = SKTexture(imageNamed: "ok0")
                loadSelf()
                
            }
            return "none"
        }
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
