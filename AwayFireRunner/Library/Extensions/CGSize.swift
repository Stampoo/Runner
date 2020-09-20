//
//  File.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import CoreGraphics

extension CGSize {

    var midX: CGFloat {
        self.width / 2
    }
    
    var midY: CGFloat {
        self.height / 2
    }

    var center: CGPoint {
        .init(x: self.midX, y: self.midY)
    }

}
