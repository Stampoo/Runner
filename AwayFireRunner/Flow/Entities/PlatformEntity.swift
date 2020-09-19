//
//  PlatformEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 18/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class PlatformEntity: GKEntity {

    //MARK: - Public properties

    let node: SKSpriteNode
    let body: SKPhysicsBody

    //MARK: - Initializers

    init(size: CGSize) {
        node = SKSpriteNode(color: .brown, size: size)
        body = SKPhysicsBody(rectangleOf: node.size)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
