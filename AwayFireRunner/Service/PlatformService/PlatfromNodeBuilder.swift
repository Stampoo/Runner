//
//  PlatfromNodeBuilder.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class PlatformNodeBuilder {

    //MARK: - Private properties

    private let leftPlatform = SKTexture(imageNamed: "PlatformLeft")
    private let rightPlatform = SKTexture(imageNamed: "PlatformRight")
    private let middlePlatform = SKTexture(imageNamed: "Platform")
    private let nodeSize: CGSize

    //MARK: - Initializers

    init(nodeSize: CGSize) {
        self.nodeSize = nodeSize
    }

    //MARK: - Public methods

    func create(length: Int, position: CGPoint) -> SKNode {
        let platform = createPlatform(length: length, position: position)
        createPlatformBody(for: platform, at: length)
        return platform
    }

    //MARK: - Private methods

    private func createPlatform(length: Int, position: CGPoint) -> SKNode {
        let container = SKNode()
        for index in 1...length {
            switch index {
            case 1:
                createNode(with: leftPlatform, putTo: container, index: index)
            case length:
                createNode(with: rightPlatform, putTo: container, index: index)
            default:
                createNode(with: middlePlatform, putTo: container, index: index)
            }
        }
        container.name = "Platform"
        container.position = position
        return container
    }

    private func createNode(with texture: SKTexture?, putTo node: SKNode, index: Int) {
        let index = CGFloat(index - 1)
        let newNode = SKSpriteNode(texture: texture)
        newNode.size = nodeSize
        newNode.zPosition = 2
        node.addChild(newNode)
        newNode.position = .init(x: index * nodeSize.width, y: 0)
    }

    private func createPlatformBody(for node: SKNode, at length: Int) {
        let bodyLength = nodeSize.width * CGFloat(length)
        let bodySize = CGSize(width: bodyLength, height: nodeSize.height)
        let center = CGPoint(x: nodeSize.width / 2 * CGFloat(length) - nodeSize.width / 2, y: 0)
        let body = SKPhysicsBody(rectangleOf: bodySize, center: center)
        body.categoryBitMask = CollisionBitMask.platformCategory
        body.isDynamic = false
        body.restitution = 0
        node.physicsBody = body
    }

}
