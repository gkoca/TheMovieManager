//
//  LoginPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

final class LoginPresentationModel: BasePresentationModel {
	
	weak var viewController: LoginViewControllerProtocol? {
		get {
			return self.baseViewController as? LoginViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: LoginRouterProtocol? {
		get {
			return self.baseRouter as?  LoginRouterProtocol
		}
		set {
			self.baseRouter = newValue
		}
	}
	
	var authentication: AuthenticationBusinessModelProtocol
	var isSessionCreated: Bool = false
	var loginProcessType: LoginProcessType = .none
	
	// MARK: - initialize with businessModel(s)
	init(with authentication: AuthenticationBusinessModelProtocol) {
		self.authentication = authentication
		super.init()
		self.authentication.delegate = self
	}
	
	func loadScene(completion: @escaping ((LoginViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Login", bundle: nil)
		let viewController: LoginViewController = storyBoard.instantiateViewController()
		let router = LoginRouter(viewController: viewController)
		self.viewController = viewController
		self.router = router
		viewController.presentationModel = self
		viewController.loadViewIfNeeded()
		
		completion(viewController)
	} 
}

// MARK: - LoginPresentationModelProtocol methods
extension LoginPresentationModel: LoginPresentationModelProtocol {
	func presentWebLogin() {
		authentication.createRequestToken { [weak self] (isSuccess, responseMessage) in
			if isSuccess {
				self?.navigate(.webLogin(token: responseMessage, delegate: self))
			} else {
				self?.viewController?.didFailure(errorText: responseMessage)
			}
		}
	}
	
	func login(username: String, password: String) {
		authentication.login(username: username, password: password)
	}
	
	func navigate(_ route: LoginRoutes) {
		router?.navigate(route)
	}
}

// MARK: - BusinessModelDelegate methods
extension LoginPresentationModel: AuthenticationBusinessModelDelegate {
	func handleOutput(_ output: AuthenticationBusinessModelOutput) {
		switch output {
		case .loginFailed(let message):
			viewController?.didFailure(errorText: message)
		case .loginSuccess:
			navigate(.main)
		default:
			break
		}
	}
}

extension LoginPresentationModel: LoginViaWebSceneDelegate {
	func sceneDidDisappear() {
		if isSessionCreated {
			navigate(.main)
		}
	}
	
	func sessionCreated() {
		isSessionCreated = true
	}
}
