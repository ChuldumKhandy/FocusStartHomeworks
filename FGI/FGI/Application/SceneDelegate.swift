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
//        let nav = UINavigationController(rootViewController:  LogInAssembly.build())
//        window.rootViewController = nav
        let nav = UINavigationController(rootViewController:  MenuSceneAssembly.build())
        window.rootViewController = nav
        window.backgroundColor = .white
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
