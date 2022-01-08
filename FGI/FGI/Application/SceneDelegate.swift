//
//  SceneDelegate.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        if UserDefaults.standard.bool(forKey: SettingsKeys.userPasswordState.rawValue) {
            let navigation = UINavigationController(rootViewController:  LogInAssembly.build())
            window.rootViewController = navigation
        } else {
            let navigation = UINavigationController(rootViewController:  MenuSceneAssembly.build())
            window.rootViewController = navigation
        }
        window.backgroundColor = .white
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
