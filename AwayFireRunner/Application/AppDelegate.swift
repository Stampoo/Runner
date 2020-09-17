//
//  AppDelegate.swift
//  AwayFireRunner
//
//  Created by fivecoil on 17/09/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let startPointVC = StartPointController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startPointVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

