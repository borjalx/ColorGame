//
//  Settings.swift
//  ColorGame
//
//  Created by Borja S on 12/05/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import SpriteKit

//Categorías de los elementos (para diferenciarlos)
enum PhysicsCategories {
    static let none:UInt32 = 0
    static let ballCategory: UInt32 = 0x1           // 01
    static let switchCategory: UInt32 = 0x1 << 1    // 10
}

//Posición Z de los elementos
enum ZPositions {
    static let label:CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}
