//
//  ElementProduction.swift
//  AwayFireRunner
//
//  Created by fivecoil on 21/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

protocol ElementProduction {

    associatedtype Element where Element: SKNode

    var elements: [Element] { get set }

    func spawnElement()

    func deleteUnusedElement()

}
