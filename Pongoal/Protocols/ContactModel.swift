//
//  BitMaskManager.swift
//  Pongoal
//
//  Created by Nik Cadez on 18/12/2022.
//

import Foundation

struct ContactModel {
    static let player:UInt32 = 0x1 << 0
    static let ball:UInt32 = 0x1 << 1
    static let object:UInt32 = 0x1 << 2
    static let goal_player:UInt32 = 0x1 << 3
    static let goal_opponent:UInt32 = 0x1 << 4
}
