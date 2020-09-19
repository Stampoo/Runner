//
//  GKEntity.swift
//  AwayFireRunner
//
//  Created by fivecoil on 19/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import GameplayKit

extension GKEntity {

    func addNodeComponent(_ node: SKNode) {
        let nodeComponent = NodeComponent(node: node)
        addComponent(nodeComponent)
    }

}
