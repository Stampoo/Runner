//
//  SpikeManager.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class SpikeManager: ElementManager<SKSpriteNode> {

    override func createItem(with platform: SKNode?, and index: Int) -> SKSpriteNode {
        guard let platform = platform else {
            return SKSpriteNode()
        }
        let node = SKSpriteNode(texture: .init(imageNamed: "Spike"))
        let randomX = generateXPos(on: platform)
        let y = platform.position.y + platform.calculateAccumulatedFrame().height / 2 + itemSize.height / 2
        let position = CGPoint(x: randomX, y: y)
        node.position = position
        return node
    }

    override func createBody(for item: SKSpriteNode) {
        let body = SKPhysicsBody(rectangleOf: item.size)
        body.isDynamic = false
        item.physicsBody = body
    }

    private func generateXPos(on paltform: SKNode?) -> CGFloat {
        let width = paltform?.calculateAccumulatedFrame().width ?? 0
        let min = width - width - itemSize.width
        let max = width - itemSize.width
        return CGFloat.random(in: min...max)
    }

}
