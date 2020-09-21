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
    private var itemName: String? {
        "Coin"
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
        for index in 0...coinsNumber(on: platform) {
            let index = CGFloat(index + 1)
            let coinPosition = CGPoint(x: platform.position.x + coinSize.width * index, y: spawnHeight)
            let coin = createCoin(coinPosition, coinSize)
            createBodyCoin(for: coin)
            scene.addChild(coin)
            coinsInGame.append(coin)
        }

    }

    func collectCoin(_ coin: SKNode?) {
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

    private func removeFromScene(_ coin: SKNode?) {
        coin?.removeFromParent()
    }

    private func createCoin(_ position: CGPoint, _ size: CGSize) -> SKSpriteNode {
        let coinTextures = Array(0...3).map { SKTexture(imageNamed: "Coin\($0)") }
        let action = SKAction.repeatForever(.animate(with: coinTextures, timePerFrame: 0.2))
        let coin = SKSpriteNode(texture: coinTextures.first)
        coin.run(action)
        coin.position = position
        coin.size = size
        coin.name = itemName
        return coin
    }

    private func createBodyCoin(for node: SKSpriteNode) {
        let body = SKPhysicsBody(rectangleOf: node.size)
        body.isDynamic = false
        body.categoryBitMask = CollisionBitMask.enemyCategory
        body.contactTestBitMask = CollisionBitMask.playerMask
        node.physicsBody = body
    }

    private func coinsNumber(on platform: SKNode?) -> Int {
        let platfromParts = platform?.children.count ?? 0
        return Array(0...platfromParts - 2).randomElement() ?? 0
    }

}
