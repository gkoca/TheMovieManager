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
			window.rootViewController = viewController
			self.window = window
			self.window?.makeKeyAndVisible()
		}
	}
	
	func presentMain() {
		guard let window = window else { return }
		MainBuilder.build { (controller) in
			let navController = UINavigationController(rootViewController: controller)
			window.rootViewController = navController
			window.makeKeyAndVisible()
			UIView.transition(with: window,
							  duration: 0.24,
							  options: .transitionFlipFromLeft,
							  animations: nil,
							  completion: nil)
		}
	}
	
	func presentLogin() {
		guard let window = window else { return }
		LoginBuilder.build { viewController in
			window.rootViewController = viewController
			window.makeKeyAndVisible()
			UIView.transition(with: window,
							  duration: 0.24,
							  options: .transitionFlipFromRight,
							  animations: nil,
							  completion: nil)
		}
	}
}

