//
//  EntityManager.swift
//  AwayFireRunner
//
//  Created by fivecoil on 17/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class EntityManager {

    //MARK: - Private properties

    private var entities = Set<GKEntity>()
    private let scene: SKScene

    //MARK: - Initializers

    init(scene: SKScene) {
        self.scene = scene
    }

    //MARK: - Public methods

    func add(entity: GKEntity) {
        entities.insert(entity)
        guard let nodeComponent = entity.component(ofType: NodeComponent.self) else {
            fatalError("node not found!")
        }
        scene.addChild(nodeComponent.node)
    }


}
