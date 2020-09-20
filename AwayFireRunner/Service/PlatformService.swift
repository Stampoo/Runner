//
//  PlatformService.swift
//  AwayFireRunner
//
//  Created by fivecoil on 19/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class PlatformService {

    //MARK: - Constants

    private enum Constants {
        static let screenSize = UIScreen.main.bounds.size
        static let screenHeight = UIScreen.main.bounds.size.height
        static let screenWidth = UIScreen.main.bounds.size.width
        static let maxHeight = Constants.screenHeight * 0.5
        static let minHeight: CGFloat = 0
    }

    //MARK: - Priavte properties

    private let leftPlatform = SKTexture(imageNamed: "PlatformLeft")
    private let rightPlatform = SKTexture(imageNamed: "PlatformRight")
    private let middlePlatform = SKTexture(imageNamed: "Platform")
    private let scene: SKScene
    private let blockSize: CGSize
    private let maxPlatformLength = 7
    private let minPlatformLength = 2
    private var minRangeToBounds: CGFloat {
        blockSize.height
    }
    private let betweenRange = Constants.screenWidth * 0.1
    private(set) var currentPlatforms = [SKNode]()
    private var startPlatform = SKNode()

    //MARK: - Initializers

    init(scene: SKScene, blockSize: CGSize) {
        self.blockSize = blockSize
        self.scene = scene
    }

    //MARK: - Public properties

    func setupStartPlatform() {
        let platformLength = Int(Constants.screenWidth / blockSize.width)
        startPlatform = createPlatform(at: .zero, length: platformLength, oldPlatformLength: 0)
    }

    func generatePlatform(camera position: CGPoint) {
        let length = generatePlatformLength()
        let oldLength = currentPlatforms.last?.children.count ?? 0
        _ = createPlatform(at: currentPlatforms.last?.position ?? .zero,
                           length: length, oldPlatformLength: oldLength - 1)
        removeNotActualPlatforms(with: position)
    }

    func removeNotActualPlatforms(with cameraPosition: CGPoint?) {
        guard let position = cameraPosition else {
            return
        }
        let bounds = position.x - Constants.screenSize.width
        let platformToremove = currentPlatforms.filter { $0.position.x < bounds }
        platformToremove.forEach { $0.removeFromParent() }
        currentPlatforms = currentPlatforms.filter { $0.position.x > bounds }
    }

    //MARK: - Private propertties

    private func createPlatform(at position: CGPoint, length: Int, oldPlatformLength: Int) -> SKNode {
        let commonNode = SKNode()
        let position = generatePlatformPosition(with: position, at: oldPlatformLength, to: length)
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
        createPlatformBody(for: commonNode, at: length)
        scene.addChild(commonNode)
        currentPlatforms.append(commonNode)
        return commonNode
    }

    private func createNode(with texture: SKTexture?, to node: SKNode?, at index: Int) {
        let cgIndex = CGFloat(index)
        let skNode = SKSpriteNode(texture: texture)
        skNode.size = blockSize
        skNode.position = .init(x: blockSize.width * cgIndex, y: node?.position.y ?? 0)
        node?.physicsBody?.isDynamic = false
        node?.physicsBody?.categoryBitMask = CollisionBitMask.floorCategory
        node?.addChild(skNode)
    }

    private func generatePlatformLength() -> Int {
        Int.random(in: minPlatformLength...maxPlatformLength)
    }

    private func createPlatformBody(for node: SKNode, at length: Int) {
        let bodyLength = blockSize.width * CGFloat(length)
        let bodySize = CGSize(width: bodyLength, height: blockSize.height)
        let center = CGPoint(x: blockSize.width / 2 * CGFloat(length) - blockSize.width / 2, y: 0)
        let body = SKPhysicsBody(rectangleOf: bodySize, center: center)
        body.isDynamic = false
        node.physicsBody = body
    }

    private func generatePlatformPosition(with currentPosition: CGPoint,
                                          at oldPlatformLength: Int,
                                          to newPlatformLength: Int) -> CGPoint {
        let possibleWaysY = [
            -Constants.screenWidth * 0.1,
            Constants.screenWidth * 0.1,
            0
            ].map { $0 + currentPosition.y }
        let currentPlatform = currentPlatforms.last?.calculateAccumulatedFrame().size ?? .zero
        let xPosition = currentPosition.x + currentPlatform.width / 2 + calcLength(newPlatformLength) / 2 + betweenRange
        let yPosition = possibleWaysY.randomElement() ?? 0
        return boundsEvader(.init(x: xPosition, y: yPosition))
    }

    private func boundsEvader(_ position: CGPoint) -> CGPoint {
        switch position.y {
        case ..<(Constants.minHeight + minRangeToBounds):
            return .init(x: position.x, y: position.y + Constants.screenHeight * 0.2)
        case (Constants.maxHeight - minRangeToBounds)...Constants.maxHeight:
            return .init(x: position.x, y: position.y - Constants.screenHeight * 0.2)
        default:
            break
        }
        return position
    }

    private func calcLength(_ count: Int) -> CGFloat {
        CGFloat(count) * blockSize.width
    }

}
