//
//  SearchPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class SearchPresentationModel: BasePresentationModel {
	
	weak var viewController: SearchViewControllerProtocol? {
		get {
			return self.baseViewController as? SearchViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: SearchRouterProtocol? {
		get {
			return self.baseRouter as?  SearchRouterProtocol
		}
		set {
			self.baseRouter = newValue
		}
	}
	var authentication: AuthenticationBusinessModelProtocol
	var sceneLoadingHandler: (() -> Void)?

	// MARK: - initialize with businessModel(s)
	init(with businessModel: AuthenticationBusinessModelProtocol) {
		authentication = businessModel
		super.init()
		authentication.delegate = self
	}
	
	deinit {
		LOG("\(String(describing: type(of: self))) \(#function)")
	}

	/// you should fire ´sceneLoadingHandler´ after loading process completed. 
	/// if you don't have loading process, you may send ´viewController´ directly via ´completion´
	func loadScene(completion: @escaping ((SearchViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Search", bundle: nil)
		var viewController: SearchViewController? = storyBoard.instantiateViewController()
		let router = SearchRouter(viewController: viewController!)
		self.viewController = viewController
		self.router = router
		viewController?.presentationModel = self
		viewController?.loadViewIfNeeded()
//		sceneLoadingHandler = {
		if let viewController = viewController {
			completion(viewController)
		}
		viewController = nil
//		}
		// start loading process here
	} 
}

// MARK: - SearchPresentationModelProtocol methods
extension SearchPresentationModel: SearchPresentationModelProtocol {
	func logout() {
		authentication.logout()
	}
	
	func navigate(_ route: SearchRoutes) {
		router?.navigate(route)
	}
}

// Conform businessModelDelegates
// MARK: - BusinessModelDelegate methods
extension SearchPresentationModel: AuthenticationBusinessModelDelegate {
	func handleOutput(_ output: AuthenticationBusinessModelOutput) {
		switch output {
		case .logoutFailed(let message):
			viewController?.didFailure(errorText: message)
		case .logoutSuccess:
			navigate(.logout)
		default:
			break
		}
	}
}
