//
//  Operators.swift
//  AwayFireRunner
//
//  Created by fivecoil on 20/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import CoreGraphics

func /(lhs: CGSize, rhs: Int) -> CGSize {
    .init(width: lhs.width / 2, height: lhs.height / 2)
}
