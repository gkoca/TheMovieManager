//
//  LoginViaWebRouter.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class LoginViaWebRouter: LoginViaWebRouterProtocol {
	unowned var viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func navigate(_ route: LoginViaWebRoutes) {
		switch route {
		}
	}
}
