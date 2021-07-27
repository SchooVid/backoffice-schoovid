//
//  AppDelegate.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        let firstController = AuthenticationViewController(nibName:"AuthenticationViewController",bundle:nil)
        let window = UIWindow(frame:UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController : firstController)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    

}

