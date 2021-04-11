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
	var authentication: AuthenticationBusinessModelProtocol
	var requestToken: String
	var authenticationURL: URL
	
	weak var delegate: LoginViaWebSceneDelegate?

	init(requestToken: String, url: URL, businessModel: AuthenticationBusinessModelProtocol) {
		self.requestToken = requestToken
		self.authenticationURL = url
		self.authentication = businessModel
		super.init()
	}

	func loadScene(completion: @escaping ((LoginViaWebViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "LoginViaWeb", bundle: nil)
		var viewController: LoginViaWebViewController? = storyBoard.instantiateViewController()
		let router = LoginViaWebRouter(viewController: viewController!)
		self.viewController = viewController
		self.router = router
		viewController?.presentationModel = self
		viewController?.loadViewIfNeeded()
		if let viewController = viewController {
			completion(viewController)
		}
		viewController = nil
	}
}

// MARK: - LoginViaWebPresentationModelProtocol methods
extension LoginViaWebPresentationModel: LoginViaWebPresentationModelProtocol {
	func viewDidDisappear() {
		delegate?.sceneDidDisappear()
	}
	
	func createSession() {
		authentication.createSession(with: requestToken) { [weak self] (isSuccess, responseMessage) in
			if isSuccess {
				self?.delegate?.sessionCreated()
				self?.viewController?.handleOutput(.sessionCreated)
			} else {
				self?.viewController?.didFailure(errorText: responseMessage)
			}
		}
	}
	
	func navigate(_ route: LoginViaWebRoutes) {
		router?.navigate(route)
	}
}
