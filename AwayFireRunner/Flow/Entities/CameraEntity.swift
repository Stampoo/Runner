//
//  CameraEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class CameraEntity: GKEntity {

    //MARK: - Public properties

    let node: SKCameraNode

    //MARK: - Initializers

    init(position: CGPoint) {
        node = SKCameraNode()
        node.position = position
        super.init()
        addNodeComponent(node)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods

    func moveCamera(on pointX: CGFloat?) {
        node.position.x = pointX ?? 0
    }

}
