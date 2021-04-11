//
//  MainRouter.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class MainRouter: MainRouterProtocol {
	unowned var viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func navigate(_ route: MainRoutes) {
		switch route {
		case .logout:
			(viewController.view.window?.windowScene?.delegate as? SceneDelegate)?.presentLogin()
		}
	}
}
