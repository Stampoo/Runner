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
        setupBody()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods

    func pin(to positionX: CGFloat) {
        node.position.x = positionX

    }

    //MARK: - Private methods

    private func setupNode(with size: CGSize) {
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
        node.physicsBody = body
        node.position = .init(x: node.size.width / 2,
                              y: node.size.height / 2)
    }

    private func setupBody() {
        body.isDynamic = false
        body.restitution = 0
        body.friction = 0
        body.categoryBitMask = CollisionBitMask.floorCategory
        body.contactTestBitMask = CollisionBitMask.playerMask
    }

}
