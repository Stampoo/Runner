//
//  ItemManager.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit


final class ElementManager<Element> where Element: SKNode {

    private(set) var items = [Element]()

    func removeUnusedItems(at cameraPosition: CGPoint?) {
        guard let camPos = cameraPosition else {
            return
        }
        let bound = UIScreen.main.bounds.size.width
        let unusedItems = items.filter { $0.position.x < camPos.x - bound}
        unusedItems.forEach { $0.removeFromParent() }
        items = items.filter { $0.position.x > camPos.x - bound}
    }
    
}
