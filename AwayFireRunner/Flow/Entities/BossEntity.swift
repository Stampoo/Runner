//
//  LavaEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 18/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class BossEntity: GKEntity {

    //MARK: - Public properties

    let node: SKSpriteNode
    let body: SKPhysicsBody

    //MARK: - Initializers

    init(size: CGSize) {
        let texture = SKTexture(imageNamed: "Fire0")
        node = SKSpriteNode(texture: texture)
        node.size = size
        body = SKPhysicsBody(rectangleOf: size)
        super.init()
        setupNode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupNode() {
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
        node.physicsBody = body
        node.position = .init(x: node.size.width / 2, y: node.size.height )
        print(node.size)
        let textures = Array(1...4).map { SKTexture(imageNamed: "BossWalk\($0)") }
        let action = SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.2))
        node.run(action)
    }

}