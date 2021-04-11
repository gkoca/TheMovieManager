//
//  SearchRouter.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class SearchRouter: SearchRouterProtocol {
	unowned var viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func navigate(_ route: SearchRoutes) {
		switch route {
		case .logout:
			(viewController.view.window?.windowScene?.delegate as? SceneDelegate)?.presentLogin()
		case .detail(let item):
			DetailBuilder.build(item: item) { (detail) in
				self.viewController.parent?.parent?.show(detail, sender: self)
			}
		}
	}
}
