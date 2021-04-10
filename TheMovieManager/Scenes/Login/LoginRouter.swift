//
//  LoginRouter.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
	unowned var viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func navigate(_ route: LoginRoutes) {
		switch route {
		case .webLogin(let token, let delegate):
			if let authenticationBaseUrlString = Bundle.main.infoForKey("AUTHENTICATE") {
				let authenticationUrlString = "\(authenticationBaseUrlString)/\(token)"
				
				let url = URL(forceString: authenticationUrlString)
				
				LoginViaWebBuilder.build(requestToken: token, url: url, delegate: delegate) { (controller) in
					
					let navigationController = UINavigationController(rootViewController: controller)
					
					self.viewController.present(navigationController, animated: true)
				}
				
			}
			
			break
		}
	}
}
