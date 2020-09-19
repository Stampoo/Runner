//
//  CollisionService.swift
//  AwayFireRunner
//
//  Created by fivecoil on 19/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import SpriteKit

final class CollisionService {


    func contactDetector(contact: SKPhysicsContact) {
        contactCompresion(at: contact.bodyA.node, with: contact.bodyB.node)
    }

    private func contactCompresion(at aNode: SKNode?, with bNode: SKNode?) {
        switch aNode?.name {
        case "Player" where bNode?.name == "Spike":
            print("death by spike")
        default:
            break
        }
    }

}

