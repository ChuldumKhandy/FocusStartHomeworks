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
//        let nav = UINavigationController(rootViewController: DiagramSceneAssembly.build())
//        window.rootViewController = nav
        window.rootViewController = LogInAssembly.build()
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
