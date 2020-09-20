//
//  CoinManager.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class CoinManager {

    //MARK: - Public properties

    private(set) var coinsInGame = [SKSpriteNode]()
    private(set) var collectedCoins = 0

    //MARK: - Private properties

    private let scene: SKScene
    private let blockSize: CGSize
    private var coinSize: CGSize {
        blockSize / 2
    }

    //MARK: - Initializers

    init(blockSize: CGSize, scene: SKScene) {
        self.scene = scene
        self.blockSize = blockSize
    }

    //MARK: - Public methods

    func spawnCoins(on platform: SKNode?) {
        guard let platform = platform else {
            return
        }
        let coin = SKSpriteNode(imageNamed: "Coin0")
        scene.addChild(coin)
        let spawnHeight = platform.calculateAccumulatedFrame().size.height + platform.position.y
        coin.size = coinSize
        coin.position = .init(x: platform.position.x, y: spawnHeight)
    }

    func collectCoin(_ coin: SKNode) {
        collectedCoins += 1
        removeFromScene(coin)
    }

    //MARK: - Private methods

    private func removeFromScene(_ coin: SKNode) {
        coin.removeFromParent()
    }

}
