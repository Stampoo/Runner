//
//  PlatformService.swift
//  AwayFireRunner
//
//  Created by fivecoil on 19/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class PlatformGenerateService {

    //MARK: - Constants

    private enum Constants {
        static let screenHeight = UIScreen.main.bounds.size.height
        static let screenWidth = UIScreen.main.bounds.size.width
        static let maxHeight = Constants.screenHeight * 0.5
        static let minHeight: CGFloat = 0
    }

    //MARK: - Priavte properties

    private let leftPlatform = SKTexture(imageNamed: "PlatformLeft")
    private let rightPlatform = SKTexture(imageNamed: "PlatfromRight")
    private let middlePlatform = SKTexture(imageNamed: "Platform")
    private let scene: SKScene
    private let blockSize: CGSize
    private var maxPlatformLength = 7
    private var minPlatformLength = 2
    private var betweenRange = Constants.screenWidth * 0.1

    //MARK: - Initializers

    init(scene: SKScene, blockSize: CGSize) {
        self.blockSize = blockSize
        self.scene = scene
    }

    //MARK: - Public properties

    func generatePlatform() {
        createPlatform()
    }

    //MARK: - Private propertties

    private func createPlatform() {
        let commonNode = SKNode()
        let length = generatePlatformLength()
        let position = generatePlatformPosition(with: .zero, at: 0, to: length)
        for index in 0...length - 1 {
            if index == 0 {
                createNode(with: leftPlatform, to: commonNode, at: index)
            } else if index == length - 1 {
                createNode(with: rightPlatform, to: commonNode, at: index)
            } else {
                createNode(with: middlePlatform, to: commonNode, at: index)
            }
        }
        commonNode.position = position
        scene.addChild(commonNode)
    }

    private func createNode(with texture: SKTexture?, to node: SKNode?, at index: Int) {
        let cgIndex = CGFloat(index)
        let skNode = SKSpriteNode(texture: texture)
        skNode.size = blockSize
        skNode.position = .init(x: blockSize.width * cgIndex, y: blockSize.width * cgIndex)
        node?.addChild(skNode)
    }

    private func generatePlatformLength() -> Int {
        Int.random(in: minPlatformLength...maxPlatformLength)
    }

    private func generatePlatformPosition(with currentPosition: CGPoint,
                                          at oldPlatformLength: Int,
                                          to newPlatformLength: Int) -> CGPoint {
        let possibleWaysY = [
            -Constants.screenHeight * 0.1,
            Constants.screenHeight * 0.1,
            0
            ].map { $0 + currentPosition.y }
        let xPosition = currentPosition.x + calcLength(oldPlatformLength) / 2 + calcLength(newPlatformLength) / 2 + betweenRange
        return .init(x: xPosition, y: possibleWaysY.randomElement() ?? 0)
    }

    private func calcLength(_ count: Int) -> CGFloat {
        CGFloat(count) * blockSize.width
    }

}
