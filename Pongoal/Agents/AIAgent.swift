//
//  AIAgent.swift
//  Pongoal
//
//  Created by Nik Cadez on 02/01/2023.
//

import Foundation
import SpriteKit
enum AgentState {
    case easy, medium, hard, impossible
}
class AIAgent {
    private var myState : AgentState!
    
    init() {
        self.myState = AgentState.medium
        setdiff()
    }
    
    init(state s:AgentState) {
        self.myState = s
        setdiff()
    }
    
    func getState() -> AgentState {
        return myState
    }
    
    func setHardState(state: AgentState) {
        myState = state
    }
 
    private func setdiff() {
        switch(myState) {
        case .easy:
            UserDefaults.standard.set("easy", forKey: "diff")
            break
        case .none:
            break
        case .medium:
            UserDefaults.standard.set("medium", forKey: "diff")
            break
        case .hard:
            UserDefaults.standard.set("hard", forKey: "diff")
            break
        case .some(.impossible):
            UserDefaults.standard.set("impossible", forKey: "diff")
            break
        }
    }
    
    func setState(state s:String) {
        switch(s) {
        case "easy":
            myState = .easy
            print("state set to easy")
            break
        case "medium":
            myState = .medium
            print("state set to normal")
            break
        case "hard":
            myState = .hard
            print("state set to hard")
            break
        case "impossible":
            myState = .impossible
            print("state set to impossible")
            break
        default:
            myState = .none
            break
        }
    }
    
    func move(ball: SKSpriteNode, opponent:SKSpriteNode) {
        switch (myState) {
        case .easy:
            moveEasy(ball: ball, opponent: opponent)
            break
        case .medium:
            moveMedium(ball: ball,opponent: opponent)
            break
        case .hard:
            moveHard(ball: ball, opponent: opponent)
        case .none:
            break
        case .impossible:
            moveImpossible(ball: ball, opponent: opponent)
        }
        
    }
    
    func moveMedium(ball: SKSpriteNode, opponent:SKSpriteNode) {
        if (ball.position.y > 0 && ball.position.y < opponent.position.y) {
            opponent.physicsBody?.velocity.dx = ball.position.x - opponent.position.x
        } else {
            opponent.physicsBody?.velocity.dx = 0 - opponent.position.x
        }
    }
    
    func moveEasy(ball: SKSpriteNode, opponent:SKSpriteNode) {
        opponent.physicsBody?.velocity.dx = (ball.position.x - opponent.position.x) / 2
    }
    
    func moveImpossible(ball: SKSpriteNode, opponent:SKSpriteNode) {
        opponent.position.x = ball.position.x
    }
    
    func moveHard(ball: SKSpriteNode, opponent:SKSpriteNode) {
        if let velx = ball.physicsBody?.velocity.dx, let vely = ball.physicsBody?.velocity.dy {
            
            let ballVel = sqrt(pow(velx, 2) + pow(vely, 2))
            
            if (ballVel > 800) {
                moveImpossible(ball: ball, opponent: opponent)
            } else {
                moveMedium(ball: ball, opponent: opponent)
            }
        } else {
            moveMedium(ball: ball, opponent: opponent)
        }
    }
}
