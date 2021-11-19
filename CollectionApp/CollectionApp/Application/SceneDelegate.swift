//
//  SceneDelegate.swift
//  CollectionApp
//
//  Created by user on 17.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: scene)
            let navigationController = UINavigationController(rootViewController: ViewController())
            window.rootViewController = navigationController
            self.window = window
            self.window?.makeKeyAndVisible()
        }
    }
}

