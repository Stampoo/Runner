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
        node = SKSpriteNode(color: .blue, size: size)
        body = SKPhysicsBody(rectangleOf: size)
        super.init()
        setupNode(with: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private properties

    private func setupNode(with size: CGSize) {
        //let screenSize = UIScreen.main.bounds.size
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
        node.physicsBody = body
        node.physicsBody?.isDynamic = false
        node.position = .init(x: node.size.width / 2,
                              y: node.size.height / 2)
    }

}
