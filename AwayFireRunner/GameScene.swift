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
    
    private var entityManager: EntityManager?
    
    override func didMove(to view: SKView) {
        let floor = FloorEntity(size: .init(width: Constants.screenSize.width * 2,
                                            height: Constants.screenSize.height * 0.1))
        entityManager = EntityManager(scene: self)
        entityManager?.add(entity: floor)
    }

}
