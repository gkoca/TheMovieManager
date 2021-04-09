//
//  TestSceneDelegate.swift
//  TheMovieManagerTests
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

class TestSceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = TestRootViewController()
		window?.makeKeyAndVisible()
	}
}

