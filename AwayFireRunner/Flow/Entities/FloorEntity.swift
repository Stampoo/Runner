//
//  FloorEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 17/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class FloorEntity: GKEntity {

    //MARK: - Public properties

    let node: SKSpriteNode
    let body: SKPhysicsBody

    //MARK: - Initializers

    init(size: CGSize) {
        let texture = SKTexture(imageNamed: "platform")
        node = SKSpriteNode(texture: texture)
        node.size = size
        body = SKPhysicsBody(rectangleOf: size)
        super.init()
        setupNode(with: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods

    func startInfinityLoop() {
        node.position.x -= 3
        if node.position.x <= 0 {
            node.position.x = node.size.width / 2
        }

    }

    //MARK: - Private methods

    private func setupNode(with size: CGSize) {
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
        node.physicsBody = body
        node.physicsBody?.isDynamic = false
        node.position = .init(x: node.size.width / 2,
                              y: node.size.height / 2)
    }

}
