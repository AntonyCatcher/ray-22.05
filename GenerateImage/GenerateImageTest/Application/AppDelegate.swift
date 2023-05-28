//
//  AppDelegate.swift
//  GenerateImageTest
//
//  Created by Anton  on 23.05.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            window?.tintColor = UIColor.white
            UINavigationBar.appearance().barTintColor = UIColor.white
            UITabBar.appearance().barTintColor = UIColor.white
        }
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        GenerateImageStorage.shared.save()
    }
}
