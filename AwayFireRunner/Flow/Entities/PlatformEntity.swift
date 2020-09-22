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
        setupNode()
        setupBody()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods

    func setPosition() {
        node.position.x -= Sizes.speed
        if node.position.x <= -node.size.width / 2 {
            node.position = calculateSpawnPoint()
        }
    }

    private func setupNode() {
        node.physicsBody = body
        node.position = calculateSpawnPoint()
        addNodeComponent(node)
    }

    private func setupBody() {
        body.isDynamic = false
        body.categoryBitMask = CollisionBitMask.platformCategory
        body.collisionBitMask = CollisionBitMask.playerMask
    }
    
    private func calculateSpawnPoint() -> CGPoint {
        let spawnVariationsY = [
            Sizes.sceenHeight * 0.1,
            Sizes.sceenHeight * 0.2,
            Sizes.sceenHeight * 0.3
        ]
        let leftOffset = Sizes.screenWidth + node.size.width * 2
        let rightOffset = Sizes.screenWidth * 2
        let spawnVariationY = spawnVariationsY.randomElement() ?? 0
        let spawnVariationX = CGFloat.random(in: leftOffset...rightOffset)
        return .init(x: spawnVariationX, y: spawnVariationY + node.size.height / 2)
    }

}
