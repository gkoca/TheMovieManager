//
//  LoginViaWebPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class LoginViaWebPresentationModel: BasePresentationModel {
	
	weak var viewController: LoginViaWebViewControllerProtocol? {
		get {
			return self.baseViewController as? LoginViaWebViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: LoginViaWebRouterProtocol? {
		get {
			return self.baseRouter as?  LoginViaWebRouterProtocol
		}
		set {
			self.baseRouter = newValue
		}
	}
	
	
	var authenticationURL: URL

	// MARK: - initialize with businessModel(s)
	init(with url: URL) {
		self.authenticationURL = url
		super.init()
	}

	func loadScene(completion: @escaping ((LoginViaWebViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "LoginViaWeb", bundle: nil)
		let viewController: LoginViaWebViewController = storyBoard.instantiateViewController()
		let router = LoginViaWebRouter(viewController: viewController)
		self.viewController = viewController
		self.router = router
		viewController.presentationModel = self
		viewController.loadViewIfNeeded()
		completion(viewController)
	} 
}

// MARK: - LoginViaWebPresentationModelProtocol methods
extension LoginViaWebPresentationModel: LoginViaWebPresentationModelProtocol {
	func navigate(_ route: LoginViaWebRoutes) {
		router?.navigate(route)
	}
}

// Conform businessModelDelegates
// MARK: - BusinessModelDelegate methods

