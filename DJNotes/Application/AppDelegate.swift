//
//  AppDelegate.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController()
        let navigation = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }

}

