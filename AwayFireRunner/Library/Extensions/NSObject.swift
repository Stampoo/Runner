//
//  NSObjecct.swift
//  AwayFireRunner
//
//  Created by fivecoil on 18/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

extension NSObject {

    func unwrap<Element>(element: Element?, completion: (Element) -> Void) {
        guard let element = element else {
            return
        }
        completion(element)
    }
    
}
