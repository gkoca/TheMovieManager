//
//  FavoritesRouter.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class FavoritesRouter: FavoritesRouterProtocol {
	unowned var viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func navigate(_ route: FavoritesRoutes) {
		switch route {
		case .detail(let item):
			DetailBuilder.build(item: item) { (detail) in
				self.viewController.parent?.show(detail, sender: self)
			}
		}
	}
}
