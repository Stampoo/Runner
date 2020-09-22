//
//  StartController.swift
//  AwayFireRunner
//
//  Created by fivecoil on 22.09.2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class StartViewController: UIViewController {

    //MARK: - Public properties

    weak var parentVc: StartPointController?

    //MARK: - Private properties

    private let startButton = UIButton(type: .system)

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
        setConstraintsButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    //MARK: - Public methods

    private func setupButton() {
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.textAlignment = .center
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = .blue
        startButton.layer.cornerRadius = view.frame.height * 0.2 / 4
        startButton.addTarget(self, action: #selector(startButtonDidPressed), for: .touchUpInside)
    }

    @objc private func startButtonDidPressed(sender: UIButton) {
        parentVc?.setupScene()
        dismiss(animated: true, completion: nil)
    }

}

//MARK: - Extensions

extension StartViewController {

    private func setConstraintsButton() {
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: view.frame.width * 0.2),
            startButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: view.frame.height * 0.4),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                constant: view.frame.height * -0.4)
        ])
    }

}
