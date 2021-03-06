//
//  GameViewController.swift
//  AwayFireRunner
//
//  Created by fivecoil on 17/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

final class StartPointController: UIViewController {

    //MARK: - Public properties

    override var shouldAutorotate: Bool {
        true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        UIDevice.current.userInterfaceIdiom == .phone ? .allButUpsideDown : .all
    }
    override var prefersStatusBarHidden: Bool {
        true
    }

    let scene = GameScene()

    //MARK: - Lifecycle

    override func loadView() {
        view = SKView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }

    //MARK: - Private methods

    func setupScene() {
        guard let view = view as? SKView else {
            fatalError("could't cast to SKView")
        }
        scene.sceneDelegate = self
        scene.scaleMode = .resizeFill
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        view.presentScene(scene)
    }

}

//MARK: - Extensions

extension StartPointController: GameSceneDelegate {

    func gameDidFinishing() {
        let start = StartViewController()
        let lview = view as? SKView
        lview?.presentScene(nil)
        start.parentVc = self
        present(start, animated: true, completion: nil)
    }

}
