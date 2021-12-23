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
        let tabs = self.createTabs()
        window.rootViewController = tabs
        self.window = window
        self.window?.makeKeyAndVisible()
        
    }
}

private extension SceneDelegate {
    func createTabs() -> UITabBarController {
        let tabBar = UITabBarController()
        let infoVC = InfoSceneAssembly.build()
        let diagramVC = DiagramVC()
        let newsVC = NewsVC()
        infoVC.tabBarItem = self.createTab("info.circle")
        diagramVC.tabBarItem = self.createTab("chart.bar")
        newsVC.tabBarItem = self.createTab("newspaper")
        
        tabBar.setViewControllers([infoVC, diagramVC, newsVC], animated: false)
        return tabBar
    }
    
    func createTab(_ systemName: String) -> UITabBarItem {
        return UITabBarItem(title: nil, image: UIImage(systemName: systemName), tag: 0)
    }
}
