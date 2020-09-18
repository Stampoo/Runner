//
//  PlayerEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 18/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class PlayerEntity: GKEntity {

    //MARK: - Public properties

    let node: SKSpriteNode
    let body: SKPhysicsBody

    //MARK: - Initializers

    init(size: CGSize) {
        node = SKSpriteNode(color: .green, size: size)
        body = SKPhysicsBody(rectangleOf: size)
        super.init()
        setupNode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods

    //MARK: - Private methods

    private func setupNode() {
        node.physicsBody = body
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
        let screenSize = UIScreen.main.bounds.size
        node.position = .init(x: screenSize.width / 2, y: screenSize.height / 2)
    }

}
