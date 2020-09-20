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

    //MARK: - Private properties
    
    private var entityManager: EntityManager?
    private var floor: FloorEntity?
    private var player: PlayerEntity?
    private var spike: SpikeEntity?
    private var fire: BossEntity?
    private let contactService = CollisionService()
    private var platform: PlatformEntity?
    private var moviedCamera: CameraEntity?
    private var platformManager: PlatformManager?
    private var coinManager: CoinManager?
    private var playerPosBeforeGenerate: CGFloat = 0

    //MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        platformManager = PlatformManager(scene: self)
        coinManager = CoinManager(blockSize: Constants.spriteSize, scene: self)
        physicsWorld.contactDelegate = self
        setupFloor()
        setupPlayer()
        setupCamera()
        platformManager?.spawnPlatform()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.jump()
    }

    //MARK: - Private methods

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
            platformManager?.removeUnusedPlatform(currentPosition)
        }
    }

}


extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
    }

}
