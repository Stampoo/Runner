//
//  BackgroundEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 22.09.2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class BackgroundEntity: GKEntity {

    //MARK: - Public properties

    let node: SKNode
    let body: SKPhysicsBody

    //MARK: - Initializers

    init(size: CGSize) {
        node = SKNode()
        body = SKPhysicsBody()
        super.init()
        setupNode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public properties

    func startMove(with playerPos: CGPoint?) {
        let playerPos = playerPos ?? .zero
        node.position.x += 2
        if node.position.x < playerPos.x - Sizes.screenWidth {
            node.position.x = playerPos.x
        }
    }

    //MARK: - Private properties

    private func setupNode() {
        let texure = SKTexture(imageNamed: "Background")
        for index in 0...1 {
            let nodePart = SKSpriteNode(texture: texure)
            nodePart.size = .init(width: Sizes.screenWidth, height: Sizes.sceenHeight)
            nodePart.position = .init(x: Sizes.screenWidth * CGFloat(index),
                                  y: Sizes.screenSize.midY)
            node.addChild(nodePart)
        }
        node.position = .zero
        addNodeComponent(node)
    }

}
