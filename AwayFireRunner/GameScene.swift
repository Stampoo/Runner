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
    private var platformGenerator: PlatformGenerateService?

    //MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        platformGenerator = PlatformGenerateService(scene: self, blockSize: Constants.spriteSize)
        view.isUserInteractionEnabled = true
        physicsWorld.contactDelegate = self
        setupFloor()
        setupPlayer()
        setupSpike()
        setupFire()
        setupPlatform()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.jump()
    }

    //MARK: - Private methods

    private func setupFloor() {
        floor = FloorEntity(size: .init(width: Constants.screenSize.width * 2,
                                        height: Constants.screenSize.height * 0.1))
        entityManager?.add(entity: floor)
    }

    private func setupPlayer() {
        player = PlayerEntity(size: Constants.spriteSize)
        entityManager?.add(entity: player)
    }

    private func setupSpike() {
        spike = SpikeEntity(size: Constants.spriteSize)
        entityManager?.add(entity: spike)
        spike?.spawnNode()
    }

    private func setupFire() {
        fire = BossEntity(size: .init(width: Constants.spriteSide * 2.5,
                                      height: Constants.spriteSide * 2))
        entityManager?.add(entity: fire)
    }

    private func setupPlatform() {
        platform = PlatformEntity(size: Constants.spriteSize)
        entityManager?.add(entity: platform)
    }
    
}


//MARK: - Extensions

extension GameScene {

    override func update(_ currentTime: TimeInterval) {
        floor?.startInfinityLoop()
        platform?.setPosition()
        spike?.node.position.x -= 2
        entityManager?.spawnSpike()
    }

}


extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        contactService.contactDetector(contact: contact)
        platformGenerator?.generatePlatform()
    }

}
