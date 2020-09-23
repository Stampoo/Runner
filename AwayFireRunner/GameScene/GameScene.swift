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
    private(set) var coinManager: CoinManager?

    //MARK: - Private properties

    private var floor: FloorEntity?
    private var player: PlayerEntity?
    private var platform: PlatformEntity?
    private var moviedCamera: CameraEntity?
    private var background: BackgroundEntity?

    private var contactService: CollisionService?

    private var entityManager: EntityManager?
    private var platformManager: PlatformManager?
    private var spikeManager: SpikeManager?

    //MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        startNewGame()
        background = BackgroundEntity(size: Sizes.screenSize)
        entityManager?.add(entity: background)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let state = player?.isJumping,
           state == false {
            player?.jump()
        }
    }

    //MARK: - Public methods

    func startNewGame() {
        contactService = CollisionService(scene: self)
        spikeManager = SpikeManager(scene: self, itemSize: Constants.spriteSize / 2)
        entityManager = EntityManager(scene: self)
        platformManager = PlatformManager(scene: self)
        coinManager = CoinManager(blockSize: Constants.spriteSize, scene: self)
        setupFloor()
        setupPlayer()
        setupCamera()
        platformManager?.spawnPlatform()
    }

    func endGame() {
        player?.death()
        cleanScene()
        sceneDelegate?.gameDidFinishing()
    }

    func setJumpingState() {
        player?.setJumpingState()
    }

    //MARK: - Private methods

    private func cleanScene() {
        entityManager?.removeAllEntities()
        spikeManager?.removeAll()
        platformManager?.removeAll()
        coinManager?.removeAll()
        spikeManager = nil
        entityManager = nil
        platformManager = nil
        coinManager = nil
        floor = nil
        player = nil
        moviedCamera = nil
        removeAllChildren()
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

}


//MARK: - Extensions

extension GameScene {

    override func update(_ currentTime: TimeInterval) {
        background?.startMove(with: player?.node.position)
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
        contactService?.playerWithSpike(contact)
        contactService?.playerWithCoin(contact)
        contactService?.playerWithFloor(contact)
        contactService?.playerWithPlatform(contact)
    }

}
