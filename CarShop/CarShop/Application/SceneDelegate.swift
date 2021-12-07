//
//  SceneDelegate.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        //let navigationController = UINavigationController(rootViewController: AssemblyChooseScene().build())
        let navigationController = UINavigationController(rootViewController: PriceSceneVC())
        window.rootViewController = navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

