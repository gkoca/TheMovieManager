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
	var sceneLoadingHandler: (() -> Void)?

	// MARK: - initialize with businessModel(s)
	override init() {
		super.init()
	}

	/// you should fire ´sceneLoadingHandler´ after loading process completed. 
	/// if you don't have loading process, you may send ´viewController´ directly via ´completion´
	func loadScene(completion: @escaping ((SearchViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Search", bundle: nil)
		let viewController: SearchViewController = storyBoard.instantiateViewController()
		let router = SearchRouter(viewController: viewController)
		self.viewController = viewController
		self.router = router
		viewController.presentationModel = self
		viewController.loadViewIfNeeded()
		sceneLoadingHandler = {
			completion(viewController)
		}
		// start loading process here
	} 
}

// MARK: - SearchPresentationModelProtocol methods
extension SearchPresentationModel: SearchPresentationModelProtocol {
	func navigate(_ route: SearchRoutes) {
		router?.navigate(route)
	}
}

// Conform businessModelDelegates
// MARK: - BusinessModelDelegate methods

