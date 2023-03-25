//
//  AppDelegate.swift
//  BeerCollectionApp
//
//  Created by Алексей Поддубный on 28.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var root: RootRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        root = RootRouter()
        window = root?.entry()
        self.window?.makeKeyAndVisible()
       
        return true
    }


}

