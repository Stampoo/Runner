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
    private var platformGenerator: PlatformGenerateService?

    //MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        platformGenerator = PlatformGenerateService(scene: self, blockSize: Constants.spriteSize)
        physicsWorld.contactDelegate = self
        setupFloor()
        setupPlayer()
        setupCamera()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.jump()
    }

    //MARK: - Private methods

    private func setupFloor() {
        floor = FloorEntity(size: .init(width: Constants.screenSize.width,
                                        height: Constants.screenSize.height * 0.1))
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
        player?.node.position.x += 1
        moviedCamera?.moveCamera(on: player?.node.position.x)
        guard let floor = floor?.node,
        let movedCamera = camera else {
            return
        }
        if floor.position.x <= movedCamera.position.x - Constants.screenSize.midX {
            guard let playerPos = player?.node.position else {
                return
            }
            let newPosition = CGPoint(x: playerPos.x, y: playerPos.y)
            platformGenerator?.generatePlatform(oldPlatform: newPosition)
            floor.position.x = playerPos.x
            platformGenerator?.removeNotActualPlatforms(with: playerPos)
        }
    }

}


extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
    }

}
