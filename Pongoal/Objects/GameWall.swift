//
//  GameWall.swift
//  Pongoal
//
//  Created by Nik Cadez on 29/12/2022.
//

import Foundation
import SpriteKit

class GameWall {
    var spriteNode: SKNode
    
    init(node sNode: SKNode) {
        self.spriteNode = sNode
        self.spriteNode.physicsBody?.categoryBitMask = ContactModel.object
        hide()
    }
    func hide() {
        spriteNode.isHidden = true
    }
    func unhide() {
        spriteNode.isHidden = false
    }
}
