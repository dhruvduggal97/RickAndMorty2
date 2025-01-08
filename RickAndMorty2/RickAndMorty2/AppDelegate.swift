//
//  AppDelegate.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let nav = UINavigationController.init()
        mainCoordinator = MainCoordinator(navigationController: nav)
        mainCoordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = nav
        return true
    }



}
