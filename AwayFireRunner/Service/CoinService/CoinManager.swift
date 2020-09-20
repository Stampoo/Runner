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
        let spawnHeight = platform.calculateAccumulatedFrame().size.height + platform.position.y
        let coin = createCoin(.init(x: platform.position.x, y: spawnHeight), coinSize)
        scene.addChild(coin)
        coinsInGame.append(coin)
    }

    func collectCoin(_ coin: SKNode) {
        collectedCoins += 1
        removeFromScene(coin)
    }

    func removeUnusedCoin(at cameraPosition: CGPoint?) {
        guard let camPos = cameraPosition else {
            return
        }
        let unusedCoins = coinsInGame.filter { $0.position.x < camPos.x - UIScreen.main.bounds.size.width }
        unusedCoins.forEach { $0.removeFromParent() }
        coinsInGame = coinsInGame.filter { $0.position.x > camPos.x - UIScreen.main.bounds.size.width }
    }

    //MARK: - Private methods

    private func removeFromScene(_ coin: SKNode) {
        coin.removeFromParent()
    }

    private func createCoin(_ position: CGPoint, _ size: CGSize) -> SKSpriteNode {
        let coinTextures = Array(0...3).map { SKTexture(imageNamed: "Coin\($0)") }
        let action = SKAction.repeatForever(.animate(with: coinTextures, timePerFrame: 0.2))
        let coin = SKSpriteNode(texture: coinTextures.first)
        coin.run(action)
        coin.position = position
        coin.size = size
        return coin
    }

}
