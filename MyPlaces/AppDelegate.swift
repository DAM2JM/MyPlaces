//
//  AppDelegate.swift
//  MyPlaces
//
//  Created by PC-793 on 6/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let manager = ManagerPlaces.shared()

        var pl = Place(name: "Test Place 1", description: "More info 1", image_in: nil )
        var p2 = Place(name: "Test Place 2", description: "More info 1", image_in: nil )
        var p3 = Place(name: "Test Place 3", description: "More info 1", image_in: nil )
        manager.append(value: pl)
        manager.append(value: p2)
        manager.append(value: p3)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

