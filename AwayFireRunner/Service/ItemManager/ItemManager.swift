//
//  ItemManager.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit


class ElementManager<Element> where Element: SKNode {

    //MARK: - Public properties

    private(set) var items = [Element]()
    let itemSize: CGSize
    let scene: SKScene
    var itemName: String? {
        "item"
    }

    //MARK: - Initializers

    init(scene: SKScene, itemSize: CGSize) {
        self.itemSize = itemSize
        self.scene = scene
    }

    //MARK: - Public methods

    func spawnItem(at platform: SKNode?) {
        let itemCount = calculateItemLength(at: platform)
        let correctItemCount = itemCount - 1 > -1 ? itemCount - 1 : 0
        guard itemCount > 0 else {
            return
        }
        for index in 0...correctItemCount {
            let item = createItem(with: platform, and: index)
            item.name = itemName
            createBody(for: item)
            scene.addChild(item)
        }
    }

    func createItem(with platform: SKNode?, and index: Int) -> Element {
        return Element()
    }

    func createBody(for item: Element) {
        let body = SKPhysicsBody()
        item.physicsBody = body
    }

    func removeUnusedItems(at cameraPosition: CGPoint?) {
        guard let camPos = cameraPosition else {
            return
        }
        let bound = UIScreen.main.bounds.size.width
        let unusedItems = items.filter { $0.position.x < camPos.x - bound}
        unusedItems.forEach { $0.removeFromParent() }
        items = items.filter { $0.position.x > camPos.x - bound}
    }

    func removeAll() {
        items.forEach { $0.removeFromParent() }
        items = []
    }

    func calculateItemLength(at platform: SKNode?) -> Int {
        let platformParts = platform?.children.count ?? 0
        return Array(0...platformParts).randomElement() ?? 0
    }
    
}
