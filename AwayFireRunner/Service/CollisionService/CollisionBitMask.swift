//
//  CollisionBitMask.swift
//  AwayFireRunner
//
//  Created by fivecoil on 19/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct CollisionBitMask {
    static let playerMask: UInt32 = 0x1 << 1
    static let enemyCategory: UInt32 = 0x1 << 2
    static let targetCategory: UInt32 = 0x1 << 3
    static let floorCategory: UInt32 = 0x1 << 4
    static let platformCategory: UInt32 = 0x1 << 5
}

