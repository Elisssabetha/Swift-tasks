//
//  AppDelegate.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 22.04.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let window = UIWindow()
        self.window = window
        
        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage) //for my img
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
//
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        return true
    }
    
    
}

