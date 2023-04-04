//
//  GameBall.swift
//  Pongoal
//
//  Created by Nik Cadez on 28/12/2022.
//

import Foundation
import SpriteKit

class GameBall : GameObject {
    
    
    public var spriteNode: SKSpriteNode
    private var savedState: CGVector!
    public var restart: Bool!
    var emt: SKEmitterNode
    
    init(node spriteNode : SKSpriteNode) {
        self.spriteNode = spriteNode
        self.savedState = CGVector(dx: 0, dy: 0)
        self.restart = false
        // set the body s catagory bitmask
        self.spriteNode.physicsBody?.categoryBitMask = ContactModel.ball
        
        // set what the body can colide with
        self.spriteNode.physicsBody?.collisionBitMask = ContactModel.player | ContactModel.object | ContactModel.opponent
        
        // what colision will we be testing
        self.spriteNode.physicsBody?.contactTestBitMask = ContactModel.goal_opponent | ContactModel.player | ContactModel.object | ContactModel.opponent | ContactModel.goal_player
        
        emt = SKEmitterNode(fileNamed: "emitor")!
        //spriteNode.addChild(emt)
        
        hide()
        animate()
    }
    
    func smokeScreen() {
        spriteNode.run(SKAction.sequence([SKAction.run({
            self.spriteNode.addChild(self.emt)
        }), SKAction.wait(forDuration: 2.0), SKAction.run({
            self.spriteNode.removeAllChildren()
        })]))
    }
    
    func randomVelocity() {
        self.spriteNode.physicsBody?.velocity = randomVector()
    }
    
    func hide() {
        self.spriteNode.isHidden = true
    }
    
    func resumeBall() {
        self.spriteNode.physicsBody?.velocity = savedState
    }
    
    func unhide() {
        self.spriteNode.isHidden = false
    }
    
    func restartVelocity() {
        self.spriteNode.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
    }
    func restartPosition() {
        self.spriteNode.position = CGPoint(x: 0, y: 0)
    }
    
    func saveBallVelocity(state vector: CGVector) {
        self.savedState = vector
    }
    func calcAngle() -> CGFloat {
        let dx = spriteNode.physicsBody!.velocity.dx
        let dy = spriteNode.physicsBody!.velocity.dy
        return atan2(dy, dx)
    }
    func randomVector() -> CGVector {
        let rnd = Int.random(in: 1...2)
        if rnd == 1 {
            return randomVectorPlayer()
        } else {
            return randomVectorOpponent()
        }
    }
    
    func randomVectorPlayer() -> CGVector {
        let rnd = Int.random(in: -300...300)
        return CGVector(dx: rnd, dy: 500)
    }
    func randomVectorOpponent() -> CGVector {
        let rnd = Int.random(in: -300...300)
        return CGVector(dx: rnd, dy: -500)
    }

    func start() {
        unhide()
        randomVelocity()
    }
    
    func animate() {
        spriteNode.removeAllActions()
        let ballAnimation = SKAction.animate(with: ballTextures, timePerFrame: 0.03)
        spriteNode.run(SKAction.repeatForever(ballAnimation))
    }
    
    func rotateBall() {
        /// var offset = CGFloat(Double.pi / 2)
        self.spriteNode.zRotation = calcAngle()// - offset
    }
    
    private var ballAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "ball")
    }
    
    private var ballTextures: [SKTexture] {
        return [
            ballAtlas.textureNamed("frame1"),
            ballAtlas.textureNamed("frame2"),
            ballAtlas.textureNamed("frame3"),
            ballAtlas.textureNamed("frame4"),
            ballAtlas.textureNamed("frame5"),
            ballAtlas.textureNamed("frame6")
            
        ]
    }
}
