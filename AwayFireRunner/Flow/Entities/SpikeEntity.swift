//
//  SpikeEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 18/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class SpikeEntity: GKEntity {

    //MARK: - Public properties

    let node: SKSpriteNode
    let body: SKPhysicsBody

    //MARK: - Initializers

    init(size: CGSize) {
        node = SKSpriteNode(color: .red, size: size)
        body = SKPhysicsBody(rectangleOf: size)
        super.init()
        setupNode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods

    func spawnNode() {
        let nodeSize = Sizes.screenSize.width * 0.1
        let leftOffset = Sizes.screenSize.width + CGFloat.random(in: nodeSize...nodeSize + 20)
        let rightOffset = Sizes.screenSize.width * 2 - CGFloat.random(in: nodeSize...nodeSize + 20)
        let randomXPosition = CGFloat.random(in: leftOffset...rightOffset)
        node.position = .init(x: randomXPosition, y: nodeSize / 2)
    }

    //MARK: - Private methods

    private func setupNode() {
        node.physicsBody = body
    }

}
