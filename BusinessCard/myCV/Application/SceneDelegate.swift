//
//  SceneDelegate.swift
//  BusinessCard
//
//  Created by user on 13.11.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: scene)
            let tabs = self.createTabs()
            window.rootViewController = tabs
            self.window = window
            self.window?.makeKeyAndVisible()
        }
    }
}

private extension SceneDelegate {
    func createTabs() -> UITabBarController {
        let tabBar = UITabBarController()
        let persInfVC = PersonalInfoViewController()
        let devVC = DeveloperSkillsViewController()
        let hobbyVC = HobbyViewController()
        persInfVC.tabBarItem = self.createTab("figure.wave")
        devVC.tabBarItem = self.createTab("keyboard")
        hobbyVC.tabBarItem = self.createTab("paintbrush.pointed")
        
        tabBar.setViewControllers([persInfVC, devVC, hobbyVC], animated: false)
        return tabBar
    }
    
    func createTab(_ systemName: String) -> UITabBarItem {
        return UITabBarItem(title: nil, image: UIImage(systemName: systemName), tag: 0)
    }
}
