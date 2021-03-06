//
//  AppDelegate.swift
//  funda_demo_ios
//
//  Created by Pavel Zarudnev on 24.08.2021.
//

import UIKit
// Used to connect plugins (only if you have plugins with iOS platform code).
import FlutterPluginRegistrant

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var flutterEngine = FlutterEngine(name: "flutter_engine")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run()
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
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

