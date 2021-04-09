//
//  SceneDelegate.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene,
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		LoginBuilder.build { viewController in
			guard let windowScene = (scene as? UIWindowScene) else { return }
			let window = UIWindow(windowScene: windowScene)
			let navigationController = UINavigationController(rootViewController: viewController)
			window.rootViewController = navigationController
			self.window = window
			self.window?.makeKeyAndVisible()
		}
	}
}

