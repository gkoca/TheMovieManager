//
//  WatchlistRouter.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class WatchlistRouter: WatchlistRouterProtocol {
	unowned var viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func navigate(_ route: WatchlistRoutes) {
		switch route {
		}
	}
}
