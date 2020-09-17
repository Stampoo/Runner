//
//  BodyComponent.swift
//  AwayFireRunner
//
//  Created by fivecoil on 17/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

final class BodyComponent: GKComponent {

    //MARK: - Public properties

    var body: SKPhysicsBody

    //MARK: - Initializers

    init(body: SKPhysicsBody) {
        self.body = body
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
