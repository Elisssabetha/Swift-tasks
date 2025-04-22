//
//  AppDelegate.swift
//  Banck Card
//
//  Created by Елизавета Каранкевич on 01.04.2025.
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

