//
//  FavoritesAndWatchlistPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class FavoritesAndWatchlistPresentationModel: BasePresentationModel {
	
	weak var viewController: FavoritesAndWatchlistViewControllerProtocol? {
		get {
			return self.baseViewController as? FavoritesAndWatchlistViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: FavoritesAndWatchlistRouterProtocol? {
		get {
			return self.baseRouter as?  FavoritesAndWatchlistRouterProtocol
		}
		set {
			self.baseRouter = newValue
		}
	}
	var mode: FavoritesAndWatchlistSceneMode
	var items: [MovieItem] {
		switch mode {
		case .favorites:
			return FavoritesAndWatchlistManager.shared.favorites
		case .watchlist:
			return FavoritesAndWatchlistManager.shared.watchlist
		}
	}
	
	var sceneLoadingHandler: (() -> Void)?
	
	// MARK: - initialize with businessModel(s)
	init(mode: FavoritesAndWatchlistSceneMode) {
		self.mode = mode
		super.init()
		FavoritesAndWatchlistManager.shared.addDelegate(self)
	}
	
	func loadScene(completion: @escaping ((FavoritesAndWatchlistViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "FavoritesAndWatchlist", bundle: nil)
		var viewController: FavoritesAndWatchlistViewController? = storyBoard.instantiateViewController()
		let router = FavoritesAndWatchlistRouter(viewController: viewController!)
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

// MARK: - FavoritesAndWatchlistPresentationModelProtocol methods
extension FavoritesAndWatchlistPresentationModel: FavoritesAndWatchlistPresentationModelProtocol {
	func didSelectItem(at index: Int) {
		navigate(.detail(item: items[index]))
	}
	
	func navigate(_ route: FavoritesAndWatchlistRoutes) {
		router?.navigate(route)
	}
}

// MARK: - BusinessModelDelegate methods
extension FavoritesAndWatchlistPresentationModel: FavoritesAndWatchlistManagerDelegate {
	func didModifiedFavorites(items: [MovieItem]) {
		if mode == .favorites {
			viewController?.handleOutput(.shouldReload)
		}
	}
	
	func didModifiedWatchlist(items: [MovieItem]) {
		if mode == .watchlist {
			viewController?.handleOutput(.shouldReload)
		}
	}
}
