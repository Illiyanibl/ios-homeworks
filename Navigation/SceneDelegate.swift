//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Illya Blinov on 8.04.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)

        let tabMainViewController = UITabBarController()
        tabMainViewController.tabBar.tintColor = .systemYellow
        tabMainViewController.tabBar.unselectedItemTintColor = .darkGray
        let feedViwController = FeedViewController()
        let loginViewController = LoginViewController()

        let profileNavigationController = UINavigationController(rootViewController: loginViewController)
        profileNavigationController.navigationBar.backgroundColor = .white
        
        let feedNavigationController = UINavigationController(rootViewController: feedViwController)
        feedNavigationController.title = "Feed"
        feedNavigationController.view.backgroundColor = .darkGray

        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile") , tag: 0)
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed"), tag: 2)

        tabMainViewController.viewControllers = [profileNavigationController, feedNavigationController]
        tabMainViewController.selectedIndex = 0
        tabMainViewController.tabBar.backgroundColor = .black
        tabMainViewController.tabBar.barTintColor = .darkGray

        window.rootViewController = tabMainViewController
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

