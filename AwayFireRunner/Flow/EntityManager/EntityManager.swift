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
    @objc dynamic private var spikeIsSpawned = false
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

    //MARK: - Private methods

    private func setupNotification() {
        observer = observe(\.spikeIsSpawned, changeHandler: { [weak self] (manager, value) in
            guard let value = value.newValue else {
                return
            }
            if !value {
                let entity = self?.entities.filter { $0 as? SpikeEntity != nil } as? Set<SpikeEntity>
                entity?.first?.spawnNode()
                self?.add(entity: entity?.first)
                self?.spikeIsSpawned = false
                print("spawn")
            }
        })
    }

}
