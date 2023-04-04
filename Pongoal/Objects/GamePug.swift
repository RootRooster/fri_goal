//
//  GamePug.swift
//  Pongoal
//
//  Created by Nik Cadez on 29/12/2022.
//

import Foundation
import SpriteKit

class GamePug:GameObject {
    var spriteNode: SKSpriteNode
    var agent: AIAgent?
    let name: String!
    var animation: SKAction!
    var power: Int!
    
    init(node spriteN: SKSpriteNode, type name: String) {
        self.spriteNode = spriteN
        
        self.name = name
        
        // fix the physical body
        self.spriteNode.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: self.spriteNode.size.width - 40, height: self.spriteNode.size.height-10))
        self.spriteNode.physicsBody?.affectedByGravity = false
        self.spriteNode.physicsBody?.allowsRotation = false
        
        // create a ai agent
        self.agent = AIAgent()
        
        // set category bit mask
        if (name == "opponent") {
            self.spriteNode.physicsBody?.categoryBitMask = ContactModel.opponent
            self.power = -700
        } else {
            self.spriteNode.physicsBody?.categoryBitMask = ContactModel.player
            self.power = 700
        }
        
        // set the collision bitmask
        self.spriteNode.physicsBody?.collisionBitMask = ContactModel.object
        
        // set the animation
        self.animation = initAnimation()
    }
    
    func hide() {
        spriteNode.isHidden = true
    }
    
    func changePower(power: Int) {
        self.power = power
    }
    
    func unhide() {
        spriteNode.isHidden = false
    }
    
    func moveViaTouch(location loc: CGPoint) {
        self.spriteNode.position.x = loc.x
    }
    
    func moveViaAgent(Ball: SKSpriteNode) {
        if let agent = self.agent {
            agent.move(ball: Ball, opponent: self.spriteNode)
        }
    }
    
    func runAnimation() {
        self.spriteNode.run(self.animation)
    }
    
    func initAnimation() -> SKAction {
        if self.name == "opponent" {
            let animation = SKAction.animate(with: [
                SKTexture(imageNamed: "opponent/frame1"),
                SKTexture(imageNamed: "opponent/frame2"),
                SKTexture(imageNamed: "opponent/frame3"),
                SKTexture(imageNamed: "opponent/frame4"),
                SKTexture(imageNamed: "opponent/frame5"),
                SKTexture(imageNamed: "opponent/frame4"),
                SKTexture(imageNamed: "opponent/frame3"),
                SKTexture(imageNamed: "opponent/frame2"),
                SKTexture(imageNamed: "opponent/frame1")
            ], timePerFrame: 0.03)
            return animation
        } else {
            let animation = SKAction.animate(with: [
                SKTexture(imageNamed: "player/frame1"),
                SKTexture(imageNamed: "player/frame2"),
                SKTexture(imageNamed: "player/frame3"),
                SKTexture(imageNamed: "player/frame4"),
                SKTexture(imageNamed: "player/frame5"),
                SKTexture(imageNamed: "player/frame4"),
                SKTexture(imageNamed: "player/frame3"),
                SKTexture(imageNamed: "player/frame2"),
                SKTexture(imageNamed: "player/frame1")
            ], timePerFrame: 0.03)
            return animation
        }
        
    }
    
    func blind() {
        let old_state:AgentState = agent!.getState()
        spriteNode.run(SKAction.sequence([SKAction.run {
            self.agent?.setState(state: "none")
        }, SKAction.wait(forDuration: 2.0),SKAction.run {
            self.agent?.setHardState(state: old_state)
        }]))
    }
}
