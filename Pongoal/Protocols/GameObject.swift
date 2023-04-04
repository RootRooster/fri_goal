//
//  GameObject.swift
//  Pongoal
//
//  Created by Nik Cadez on 28/12/2022.
//
import SpriteKit
import Foundation

protocol GameObject {
    var spriteNode : SKSpriteNode {get set}
    func hide()
    func unhide()
}
