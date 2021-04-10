//
//  FavoritesPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class FavoritesPresentationModel: BasePresentationModel {
	
	weak var viewController: FavoritesViewControllerProtocol? {
		get {
			return self.baseViewController as? FavoritesViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: FavoritesRouterProtocol? {
		get {
			return self.baseRouter as?  FavoritesRouterProtocol
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
	func loadScene(completion: @escaping ((FavoritesViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Favorites", bundle: nil)
		let viewController: FavoritesViewController = storyBoard.instantiateViewController()
		let router = FavoritesRouter(viewController: viewController)
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

// MARK: - FavoritesPresentationModelProtocol methods
extension FavoritesPresentationModel: FavoritesPresentationModelProtocol {
	func navigate(_ route: FavoritesRoutes) {
		router?.navigate(route)
	}
}

// Conform businessModelDelegates
// MARK: - BusinessModelDelegate methods

