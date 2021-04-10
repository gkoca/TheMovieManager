//
//  BaseRouter.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

class BaseRouter {
	unowned var viewController: UIViewController
	
	init(viewController: UIViewController) {
		self.viewController = viewController
	}
}

extension BaseRouter: BaseRouterProtocol {
	
}

