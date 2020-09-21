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

    override func calculateItemLength(at platform: SKNode?) -> Int {
        guard let platform = platform else {
            return 0
        }
        switch platform.children.count {
        case 0...3:
            print(0)
            return 0
        case 4...7:
            let a = Int.random(in: 0...1)
            print(a)
            return a
        default:
            return 0
        }
    }

    //MARK: - Private methods

    private func generateXPos(on platform: SKNode?) -> CGFloat {
        let positionX = platform?.position.x ?? 0
        let min = positionX + itemSize.width
        let max = positionX - itemSize.width * 2 + (platform?.calculateAccumulatedFrame().width ?? 0)
        return CGFloat.random(in: min...max)
    }

}
