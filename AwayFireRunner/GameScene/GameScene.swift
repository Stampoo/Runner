//
//  GameScene.swift
//  AwayFireRunner
//
//  Created by fivecoil on 17/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class GameScene: SKScene {

    //MARK: - Constants

    private enum Constants {
        static let screenSize = UIScreen.main.bounds.size
        static let spriteSide = Constants.screenSize.width * 0.1
        static let spriteSize = CGSize(width: Constants.spriteSide, height: Constants.spriteSide)
    }

    //MARK: - Public properties

    weak var sceneDelegate: GameSceneDelegate?

    //MARK: - Private properties

    private var floor: FloorEntity?
    private var player: PlayerEntity?
    private var platform: PlatformEntity?
    private var moviedCamera: CameraEntity?

    private let contactService = CollisionService()

    private var entityManager: EntityManager?
    private var platformManager: PlatformManager?
    private var coinManager: CoinManager?
    private var spikeManager: SpikeManager?

    private var playerPosBeforeGenerate: CGFloat = 0
    private var startScene: StartScene?

    //MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        startNewGame()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.jump()
    }

    //MARK: - Public methods

    func startNewGame() {
        spikeManager = SpikeManager(scene: self, itemSize: Constants.spriteSize / 2)
        entityManager = EntityManager(scene: self)
        platformManager = PlatformManager(scene: self)
        coinManager = CoinManager(blockSize: Constants.spriteSize, scene: self)
        setupFloor()
        setupPlayer()
        setupCamera()
        platformManager?.spawnPlatform()
        print("lel")
    }

    //MARK: - Private methods

    private func cleanScene() {
        entityManager?.removeAllEntities()
        spikeManager = nil
        entityManager = nil
        platformManager = nil
        coinManager = nil
        floor = nil
        player = nil
        moviedCamera = nil
    }

    private func setupFloor() {
        floor = FloorEntity(size: .init(width: Constants.screenSize.width,
                                        height: 1))
        entityManager?.add(entity: floor)
    }

    private func setupPlayer() {
        player = PlayerEntity(size: Constants.spriteSize)
        entityManager?.add(entity: player)
    }

    private func setupCamera() {
        moviedCamera = CameraEntity(position: Constants.screenSize.center)
        entityManager?.add(entity: moviedCamera)
        camera = moviedCamera?.node
    }

    private func runStartScreen(with type: StartType) {
        startScene = StartScene(with: .restart, scene: self)
        view?.presentScene(startScene ?? SKScene())
    }
    
}


//MARK: - Extensions

extension GameScene {

    override func update(_ currentTime: TimeInterval) {
        player?.startMove()
        moviedCamera?.moveCamera(on: player?.getCurrentPos().x)
        floor?.pin(to: player?.getCurrentPos().x ?? 0)
        platformGeneratorTrigger()
    }

    private func platformGeneratorTrigger() {
        guard let lastSpawnedPlatform = platformManager?.platforms.last,
            let currentPosition = player?.getCurrentPos() else {
                return
        }
        if currentPosition.x + Sizes.screenSize.midX > lastSpawnedPlatform.position.x  {
            platformManager?.spawnPlatform()
            coinManager?.spawnCoins(on: platformManager?.platforms.last)
            coinManager?.removeUnusedCoin(at: currentPosition)
            spikeManager?.spawnItem(at: platformManager?.platforms.last)
            spikeManager?.removeUnusedItems(at: currentPosition)
            platformManager?.removeUnusedPlatform(currentPosition)
        }
    }

}


extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        let spikeName = spikeManager?.itemName ?? ""
        let playerName = player?.node.name ?? ""
        let coinName = coinManager?.coinsInGame.first?.name ?? ""
        if contactComprasion(contact, aName: playerName, bName: spikeName) {
            player?.death()
            cleanScene()
            sceneDelegate?.gameDidFinishing()
        } else if contactComprasion(contact, aName: playerName, bName: coinName) {
            coinManager?.collectCoin(contact.bodyB.node)
        }
    }
    
    private func nameItem(from item: SKNode?) -> String {
        item?.name ?? ""
    }
    
    private func contactComprasion(_ contact: SKPhysicsContact, aName: String, bName: String) -> Bool {
        guard let aNodeName = contact.bodyA.node?.name,
            let bNodeName = contact.bodyB.node?.name else {
                return false
        }
        print(aNodeName, aName, bNodeName, bName)
        return aNodeName == aName && bNodeName == bName
    }

}
