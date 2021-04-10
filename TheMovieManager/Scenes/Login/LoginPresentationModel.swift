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
	var sceneLoadingHandler: (() -> Void)?
	
	var authentication: AuthenticationBusinessModelProtocol
	
	var loginProcessType: LoginProcessType = .none

	// MARK: - initialize with businessModel(s)
	init(with authentication: AuthenticationBusinessModelProtocol) {
		self.authentication = authentication
		super.init()
		self.authentication.delegate = self
	}

	deinit {
		LOG("\(#function) \(String(describing: self))")
	}
	
	/// you should fire ´sceneLoadingHandler´ after loading process completed. 
	/// if you don't have loading process, you may send ´viewController´ directly via ´completion´
	func loadScene(completion: @escaping ((LoginViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Login", bundle: nil)
		let viewController: LoginViewController = storyBoard.instantiateViewController()
		let router = LoginRouter(viewController: viewController)
		self.viewController = viewController
		self.router = router
		viewController.presentationModel = self
		viewController.loadViewIfNeeded()
		sceneLoadingHandler = {
			completion(viewController)
		}
		// start loading process here
		sceneLoadingHandler?()
	} 
}

// MARK: - LoginPresentationModelProtocol methods
extension LoginPresentationModel: LoginPresentationModelProtocol {
	func presentWebLogin() {
		TMDBHelper.shared.createRequestToken { [weak self] (isSuccess, token) in
			if isSuccess, let token = token {
				self?.navigate(.webLogin(token: token, delegate: self))
			}
		}
	}
	
	func viewDidLoad() {
		
	}
	
	func navigate(_ route: LoginRoutes) {
		router?.navigate(route)
	}
}

// Conform businessModelDelegates
// MARK: - BusinessModelDelegate methods
extension LoginPresentationModel: AuthenticationBusinessModelDelegate {
	func handleOutput(_ output: AuthenticationBusinessModelOutput) {
		switch output {
		case .didGetToken(token: let token, expiration: let expiration):
			LOG("token: \(token)")
			LOG("expiration: \(expiration)")
		}
	}
}

extension LoginPresentationModel: LoginViaWebSceneDelegate {
	func sessionCreated() {
		LOG(#function)
	}
}
