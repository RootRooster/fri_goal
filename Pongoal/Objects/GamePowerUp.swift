//
//  GamePowerUp.swift
//  Pongoal
//
//  Created by Nik Cadez on 31/01/2023.
//

import Foundation
import SpriteKit

class GamePowerUp {
    let scene: SKScene
    let powerUp: SKShapeNode
    init(scene: SKScene) {
        self.scene = scene
        powerUp = SKShapeNode(circleOfRadius: 5)
        powerUp.zPosition = 4
        powerUp.name = "powerUp"
    }
    func addToScene() {
        scene.addChild(powerUp)
    }
    
    
}
