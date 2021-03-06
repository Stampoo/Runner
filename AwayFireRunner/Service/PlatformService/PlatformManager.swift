//
//  PlatformGenerator.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class PlatformManager {

    //MARK: - Public properties

    private(set) var platforms = [SKNode]()

    //MARK: - Private properties

    private let scene: SKScene
    private var nodeSize: CGSize {
        let side = UIScreen.main.bounds.size.width * 0.1
        return .init(width: side, height: side)
    }
    private let spawnService = SpawnPositionCalculator()
    private lazy var nodeBuilder = PlatformNodeBuilder(nodeSize: nodeSize)

    //MARK: - Initializers

    init(scene: SKScene) {
        self.scene = scene
    }

    //MARK: - Public methods

    func spawnFirstPlatform() {

    }

    func spawnPlatform() {
        let altNode = SKNode()
        altNode.position = .init(x: 0, y: UIScreen.main.bounds.height * 0.4)
        let oldPlatform = platforms.last ?? altNode
        let length = platforms.last != nil ? randomLength() : 12
        let position = spawnService.calculate(oldPosition: oldPlatform.position,
                                              oldPlatformSize: oldPlatform.calculateAccumulatedFrame().size,
                                              newPlatformWidth: lengthToWidth(length))
        let platform = nodeBuilder.create(length: length, position: position)
        platform.name = "Platform"
        scene.addChild(platform)
        platforms.append(platform)
    }

    func removeUnusedPlatform(_ cameraPosition: CGPoint?) {
        guard let position = cameraPosition else {
            return
        }
        let bounds = position.x - UIScreen.main.bounds.width * 2
        let platformToremove = platforms.filter { $0.position.x < bounds }
        platformToremove.forEach { $0.removeFromParent() }
        platforms = platforms.filter { $0.position.x > bounds }
    }

    func removeAll() {
        platforms.forEach { $0.removeFromParent() }
        platforms = []
    }

    //MARK: - Private methods

    private func randomLength() -> Int {
        Array(2...7).randomElement() ?? 0
    }

    private func lengthToWidth(_ length: Int) -> CGFloat {
        CGFloat(length) * nodeSize.width
    }

}
