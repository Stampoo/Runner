//
//  CollisionService.swift
//  AwayFireRunner
//
//  Created by fivecoil on 19/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class CollisionService {

    //MARK: - Types

    enum ContactMembers: String {
        case player = "Player"
        case spike = "Spike"
        case floor = "Floor"
        case coin = "Coin"
        case platform = "Platform"
    }

    //MARK: - Private properties

    private let scene: SKScene

    //MARK: - Initializers

    init(scene: SKScene) {
        self.scene = scene
    }

    //MARK: - Public methods

    func playerWithSpike(_ contact: SKPhysicsContact) {
        let gameScene = scene as? GameScene
        if compresion(contact: contact, firstMem: .player, secondMem: .spike) ||
            compresion(contact: contact, firstMem: .spike, secondMem: .player) {
            gameScene?.endGame()
        }
    }

    func playerWithCoin(_ contact: SKPhysicsContact) {
        let gameScene = scene as? GameScene
        if compresion(contact: contact, firstMem: .player, secondMem: .coin) ||
            compresion(contact: contact, firstMem: .coin, secondMem: .player) {
            for node in [contact.bodyA.node, contact.bodyB.node] {
                guard let name = node?.name else {
                    return
                }
                if name == "Coin" {
                    gameScene?.coinManager?.collectCoin(node)
                }
            }
        }
    }

    func playerWithFloor(_ contact: SKPhysicsContact) {
        let gameScene = scene as? GameScene
        if compresion(contact: contact, firstMem: .player, secondMem: .floor) ||
            compresion(contact: contact, firstMem: .floor, secondMem: .player) {
            gameScene?.endGame()
        }
    }

    func playerWithPlatform(_ contact: SKPhysicsContact) {
        let gameScene = scene as? GameScene
        if compresion(contact: contact, firstMem: .player, secondMem: .platform) ||
            compresion(contact: contact, firstMem: .platform, secondMem: .player) {
            gameScene?.setJumpingState()
        }
    }

    //MARK: - Private mthods

    private func compresion(contact: SKPhysicsContact?,
                            firstMem: ContactMembers,
                            secondMem: ContactMembers) -> Bool {
        let aName = contact?.bodyA.node?.name ?? ""
        let bName = contact?.bodyB.node?.name ?? ""
        return aName == firstMem.rawValue && bName == secondMem.rawValue
    }

}

