//
//  SpawnPositionCalculator.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class SpawnPositionCalculator {

    //MARK: - Private properties

    private let betweenRange = UIScreen.main.bounds.size.width * 0.1
    private let maxPlatformY = UIScreen.main.bounds.size.height * 0.5
    private let minPlatformY = UIScreen.main.bounds.size.height * 0.1
    private let platformStep = UIScreen.main.bounds.size.height * 0.1

    //MARK: - Public methods

    func calculate(oldPosition: CGPoint,
                           oldPlatformSize: CGSize,
                           newPlatformWidth: CGFloat) -> CGPoint {
        let newX = oldPosition.x + oldPlatformSize.width + betweenRange
        let newY = calculateRandomY(from: oldPosition)
        return .init(x: newX, y: newY)
    }

    //MARK: - Private methods

    private func calculateRandomY(from currentPosition: CGPoint) -> CGFloat {
        let variation = [platformStep, -platformStep, 0].map { $0 + currentPosition.y }
        let randomVariant = variation.randomElement() ?? 0
        return boundsEvader(for: randomVariant)
    }

    private func boundsEvader(for positionY: CGFloat) -> CGFloat {
        switch positionY {
        case ..<minPlatformY:
            return positionY + minPlatformY * 2
        case maxPlatformY...CGFloat.infinity:
            return positionY - minPlatformY * 2
        default:
            return positionY
        }
    }

}
