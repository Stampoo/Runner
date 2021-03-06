//
//  PlayerEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 18/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class PlayerEntity: GKEntity {
    
    //MARK: - Constants
    
    private enum Constants {
        static let runKey = "runKey"
        static let deathKey = "deathKey"
        static let jumpKey = "jumpKey"
    }

    //MARK: - Public properties

    let node: SKSpriteNode
    let body: SKPhysicsBody
    private(set) var nodeSpeed: CGFloat = 3
    private(set) var isJumping = false

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
        let jumpTexture = Array(0...3).map { SKTexture(imageNamed: "PlayerJump\($0)") }
        node.run(.animate(with: jumpTexture, timePerFrame: 0.2), withKey: Constants.jumpKey)
        body.applyImpulse(.init(dx: 0, dy: Sizes.jumpStr))
        isJumping = true
    }

    func setJumpingState() {
        isJumping = false
    }

    func startMove() {
        node.position.x += nodeSpeed
    }

    func getCurrentPos() -> CGPoint {
        node.position
    }
    
    func death() {
        let deathTexture = Array(0...5).map { SKTexture(imageNamed: "PlayerDie\($0)") }
        node.removeAction(forKey: Constants.runKey)
        node.run(.animate(with: deathTexture, timePerFrame: 0.2), withKey: Constants.deathKey)
        node.physicsBody = nil
        nodeSpeed = 0
    }

    //MARK: - Private methods

    private func setupNode() {
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
        let screenSize = UIScreen.main.bounds.size
        node.position = .init(x: screenSize.width / 2, y: screenSize.height * 0.6)
        node.name = "Player"
        node.zPosition = 2
        node.physicsBody = body
    }

    private func setupBody() {
        body.allowsRotation = false
        body.mass = 0.08
        body.restitution = 0
        body.friction = 0
        body.isDynamic = true
        body.categoryBitMask = CollisionBitMask.playerMask
        body.collisionBitMask = CollisionBitMask.floorCategory | CollisionBitMask.platformCategory
        body.contactTestBitMask = CollisionBitMask.floorCategory | CollisionBitMask.coinCategory | CollisionBitMask.spikeCategory | CollisionBitMask.platformCategory
    }

    private func runPlayer() {
        let textures = Array(0...5).map { SKTexture(imageNamed: "PlayerRun\($0)") }
        node.run(
            .repeatForever(
                .animate(with: textures, timePerFrame: 0.2)), withKey: Constants.runKey)
    }

}
