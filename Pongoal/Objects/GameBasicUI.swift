//
//  GameBasicUI.swift
//  Pongoal
//
//  Created by Nik Cadez on 29/12/2022.
//

import Foundation
import SpriteKit

enum menuType {
    case pause, none, main
}

class GameBasicUI:GameObject {
    var spriteNode: SKSpriteNode
    var textHeight: CGFloat
    var textWidth: CGFloat
    var textPos: CGPoint
    var pauseMenu:GamePauseMenu
    var mainMenu:GameMainMenu
    var menu:menuType
    
    func hide() {
        spriteNode.isHidden = true
    }
    
    func unhide() {
        spriteNode.isHidden = false
    }
    
    init(node n: SKSpriteNode) {
        self.spriteNode = n
        self.textHeight = spriteNode.size.height
        self.textWidth = spriteNode.size.width - 150
        self.textPos = spriteNode.position
        self.pauseMenu = GamePauseMenu(node: n)
        self.mainMenu = GameMainMenu(spriteNode: n)
        menu = menuType.none
    }
    
    func youLose() {
        pauseMenu.loadLose()
        spriteNode.isHidden = false
    }
    
    func youWin() {
        pauseMenu.loadWin()
        menu = menuType.pause
    }
    
    func loadPauseMenu() {
        pauseMenu.loadSelf()
        menu = menuType.pause
    }
    
    func loadMainMenu() {
        mainMenu.loadSelf()
        menu = .main
    }
    
    func ResetNode() {
        spriteNode.position = textPos
        spriteNode.size.height = textHeight
        spriteNode.size.width = textWidth
        spriteNode.removeAllChildren()
        menu = menuType.pause
        hide()
    }
    
    func touchBeginHandle(loc: CGPoint) {
        switch(menu) {
        case .pause:
            pauseMenu.handleTouchBegin(loc: loc)
            break
        case .none:
            break
        case .main:
            mainMenu.handleTouchBegin(loc: loc)
        }
    }
    
    func touchEndHandle(loc: CGPoint) -> String {
        switch(menu) {
        case .pause:
            let out = pauseMenu.handleTouchEnd(loc: loc)
            if out == "loadMain" {
                ResetNode()
                loadMainMenu()
                menu = .main
            }
            return out
        case .none:
            return "none"
        case .main:
            return mainMenu.handleTouchEnd(loc: loc)
        }
    }
    
    func touchMoveHandle(loc: CGPoint) {
        switch(menu) {
        case .pause:
            pauseMenu.handleTouchMove(loc: loc)
            break
        case .none:
            break
        case .main:
            mainMenu.handleTouchMoved(loc: loc)
        }
    }
}
