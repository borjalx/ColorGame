//
//  Settings.swift
//  ColorGame
//
//  Created by Borja S on 12/05/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none:UInt32 = 0
    static let ballCategory: UInt32 = 0x1           // 01
    static let switchCategory: UInt32 = 0x1 << 1    // 10
}
