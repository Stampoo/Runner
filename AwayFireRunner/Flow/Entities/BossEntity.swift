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
        setupBody()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupNode() {
        let textures = Array(1...4).map { SKTexture(imageNamed: "BossWalk\($0)") }
        let action = SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.2))
        node.run(action)
        node.name = "Boss"
        node.physicsBody = body
        node.position = .init(x: node.size.width / 2, y: Sizes.sceenHeight * 0.1 + node.size.height / 2)
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
    }
    
    private func setupBody() {
        body.angularVelocity = 0
        body.isDynamic = false
        body.categoryBitMask = CollisionBitMask.enemyCategory
        body.collisionBitMask = CollisionBitMask.floorCategory
    }
    
}
