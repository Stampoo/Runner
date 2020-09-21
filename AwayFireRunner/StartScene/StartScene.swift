//
//  StartScene.swift
//  AwayFireRunner
//
//  Created by fivecoil on 21/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class StartScene: SKScene {
    
    let startButton: SKLabelNode
    
    init(with type: StartType) {
        startButton = SKLabelNode(fileNamed: type.rawValue)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
