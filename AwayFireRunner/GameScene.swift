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
    }

    //MARK: - Private properties
    
    private var entityManager: EntityManager?
    private var floor: FloorEntity?
    private var player: PlayerEntity?
    private var spike: SpikeEntity?

    //MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        setupFloor()
        setupPlayer()
    }

    //MARK: - Private methods

    private func setupFloor() {
        floor = FloorEntity(size: .init(width: Constants.screenSize.width * 2,
                                        height: Constants.screenSize.height * 0.1))
        unwrap(element: floor) { floor in
            entityManager?.add(entity: floor)
        }
    }

    private func setupPlayer() {
        let side = Constants.screenSize.width * 0.1
        player = PlayerEntity(size: .init(width: side, height: side))
        unwrap(element: player) { player in
            entityManager?.add(entity: player)
        }
    }

    private func setupSpike() {
        
    }
    
}


//MARK: - Extensions

extension GameScene {

    override func update(_ currentTime: TimeInterval) {
        floor?.startInfinityLoop()
    }

}
