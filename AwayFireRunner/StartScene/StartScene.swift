//
//  StartScene.swift
//  AwayFireRunner
//
//  Created by fivecoil on 21/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class StartScene: SKScene {
    
    private let startButton: SKLabelNode
    private let gameScene: GameScene
    
    init(with type: StartType, scene: GameScene) {
        startButton = SKLabelNode(text: type.rawValue)
        self.gameScene = scene
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        let size = UIScreen.main.bounds.size
        let position = CGPoint(x: size.midX, y: size.midY)
        startButton.horizontalAlignmentMode = .center
        startButton.position = position
        startButton.fontSize = 35
        addChild(startButton)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(newGame(touch:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
    }

    @objc private func newGame(touch: UITapGestureRecognizer) {
        if startButton.contains(touch.location(in: view)) {
            gameScene.startNewGame()
        }
    }

}
