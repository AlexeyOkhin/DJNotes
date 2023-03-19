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
        let navController = UINavigationController()
        let moduleBuilder = ModuleBuilder()
        let router = Router(navigationController: navController, moduleBuilder: moduleBuilder)
        router.initialViewController()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

}

