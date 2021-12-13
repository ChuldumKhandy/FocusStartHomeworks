//
//  SceneDelegate.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.rootViewController = ViewController()
        window.backgroundColor = .white
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

