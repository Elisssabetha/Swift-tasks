//
//  AppDelegate.swift
//  Tables-Collections
//
//  Created by Елизавета Каранкевич on 29.03.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        self.window = window
        window.rootViewController = ViewController()
        
        window.makeKeyAndVisible()
        
        return true
    }




}

