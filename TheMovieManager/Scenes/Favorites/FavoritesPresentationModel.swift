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
	
	var items: [MovieItem] {
		return FavoritesAndWatchlistManager.shared.favorites
	}
	
	var sceneLoadingHandler: (() -> Void)?
	
	// MARK: - initialize with businessModel(s)
	override init() {
		super.init()
		FavoritesAndWatchlistManager.shared.addDelegate(self)
	}
	
	deinit {
		LOG("\(String(describing: type(of: self))) \(#function)")
	}
	
	func loadScene(completion: @escaping ((FavoritesViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Favorites", bundle: nil)
		var viewController: FavoritesViewController? = storyBoard.instantiateViewController()
		let router = FavoritesRouter(viewController: viewController!)
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

// MARK: - FavoritesPresentationModelProtocol methods
extension FavoritesPresentationModel: FavoritesPresentationModelProtocol {
	func didSelectItem(at index: Int) {
		navigate(.detail(item: items[index]))
	}
	
	func navigate(_ route: FavoritesRoutes) {
		router?.navigate(route)
	}
}

// MARK: - BusinessModelDelegate methods
extension FavoritesPresentationModel: FavoritesAndWatchlistManagerDelegate {
	func didModifiedFavorites(items: [MovieItem]) {
//		viewController?.handleOutput(.)
	}
}
