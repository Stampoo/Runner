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

    //MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        setupFloor()
        setupPlayer()
        setupSpike()
        setupFire()
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
        print(CGSize(width: Constants.spriteSide,
                     height: Constants.spriteSide * 2))
        entityManager?.add(entity: fire)
    }
    
}


//MARK: - Extensions

extension GameScene {

    override func update(_ currentTime: TimeInterval) {
        floor?.startInfinityLoop()
        spike?.node.position.x -= 2
        entityManager?.spawnSpike()
    }

}
