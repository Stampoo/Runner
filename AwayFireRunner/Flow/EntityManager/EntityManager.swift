//
//  EntityManager.swift
//  AwayFireRunner
//
//  Created by fivecoil on 17/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class EntityManager: NSObject {

    //MARK: - Private properties

    private var entities = Set<GKEntity>()
    private let scene: SKScene
    @objc dynamic private var spikeIsSpawned = true
    private var observer: NSKeyValueObservation?

    //MARK: - Initializers

    init(scene: SKScene) {
        self.scene = scene
        super.init()
    }

    //MARK: - Public methods

    func add(entity: GKEntity?) {
        guard let entity = entity,
            let nodeComponent = entity.component(ofType: NodeComponent.self) else {
                fatalError("node not found!")
        }
        entities.insert(entity)
        scene.addChild(nodeComponent.node)
    }

    func entity<Element>(of type: Element.Type) -> Element? {
        entities.filter { $0 as? Element != nil }.first as? Element
    }
    
    func remove(entity: GKEntity?) {
        guard let entity = entity,
            let node = entity.component(ofType: NodeComponent.self)?.node else {
            return
        }
        node.removeFromParent()
        entities.remove(entity)
    }

    func removeAllEntities() {
        for entity in entities {
            remove(entity: entity)
        }
    }

}
