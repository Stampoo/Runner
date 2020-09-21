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
        node = SKSpriteNode(texture: .init(imageNamed: "PlayerRun0"))
        node.size = size
        body = SKPhysicsBody(rectangleOf: .init(width: node.size.width / 2,
                                                height: node.size.height))
        super.init()
        setupNode()
        setupBody()
        runPlayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods

    func jump() {
        body.applyImpulse(.init(dx: 0, dy: Sizes.jumpStr))
    }

    func startMove() {
        node.position.x += Sizes.speed
    }

    func getCurrentPos() -> CGPoint {
        node.position
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
        body.mass = 0.08
        body.restitution = 0
        body.friction = 0
        body.isDynamic = true
        body.categoryBitMask = CollisionBitMask.playerMask
        body.collisionBitMask = CollisionBitMask.floorCategory
        body.contactTestBitMask = CollisionBitMask.enemyCategory
    }

    private func runPlayer() {
        let textures = Array(0...5).map { SKTexture(imageNamed: "PlayerRun\($0)") }
        node.run(.repeatForever(.animate(with: textures, timePerFrame: 0.2)))
    }

}
