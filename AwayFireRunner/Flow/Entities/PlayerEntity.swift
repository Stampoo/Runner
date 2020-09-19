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
        setupBody()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods

    func jump() {
        body.applyImpulse(.init(dx: 0, dy: Sizes.jumpStr))
    }

    //MARK: - Private methods

    private func setupNode() {
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
        let screenSize = UIScreen.main.bounds.size
        node.position = .init(x: screenSize.width / 2, y: screenSize.height / 2)
        node.name = "Player"
        node.physicsBody = body
    }

    private func setupBody() {
        body.allowsRotation = false
        body.isDynamic = true
        body.categoryBitMask = CollisionBitMask.playerMask
        body.collisionBitMask = CollisionBitMask.floorCategory
        body.contactTestBitMask = CollisionBitMask.enemyCategory
    }

}
