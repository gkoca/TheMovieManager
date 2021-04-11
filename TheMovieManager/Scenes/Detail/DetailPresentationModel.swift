//
//  DetailPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class DetailPresentationModel: BasePresentationModel {
	
	weak var viewController: DetailViewControllerProtocol? {
		get {
			return self.baseViewController as? DetailViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: DetailRouterProtocol? {
		get {
			return self.baseRouter as?  DetailRouterProtocol
		}
		set {
			self.baseRouter = newValue
		}
	}
	
	var sceneLoadingHandler: (() -> Void)?
	var item: MovieItem
	
	// MARK: - initialize with businessModel(s)
	init(item: MovieItem) {
		self.item = item
		super.init()
		FavoritesAndWatchlistManager.shared.addDelegate(self)
	}
	
	func loadScene(completion: @escaping ((DetailViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
		var viewController: DetailViewController? = storyBoard.instantiateViewController()
		let router = DetailRouter(viewController: viewController!)
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

// MARK: - DetailPresentationModelProtocol methods
extension DetailPresentationModel: DetailPresentationModelProtocol {
	func isItemInFavorites() -> Bool {
		guard let id = item.id else { return false}
		return FavoritesAndWatchlistManager.shared.isItemInFavoite(id: id)
	}
	
	func isItemInWatchlist() -> Bool {
		guard let id = item.id else { return false}
		return FavoritesAndWatchlistManager.shared.isItemInWatchlist(id: id)
	}
	
	func changeFavoriteStatus() {
		FavoritesAndWatchlistManager.shared.changeFavoriteStatus(item: item)
	}
	
	func changeWatchlistStatus() {
		FavoritesAndWatchlistManager.shared.changeWatchlistStatus(item: item)
	}
	
	func navigate(_ route: DetailRoutes) {
		router?.navigate(route)
	}
}

// MARK: - BusinessModelDelegate methods
extension DetailPresentationModel: FavoritesAndWatchlistManagerDelegate {
	func didChangeFavoriteStatus(item: MovieItem, isFavorite: Bool) {
		if item.id == self.item.id {
			viewController?.handleOutput(.didChangeFavoriteStatus(isInFavorites: isFavorite))
		}
	}
	func didChangeWatchlistStatus(item: MovieItem, isInWatchlist: Bool) {
		if item.id == self.item.id {
			viewController?.handleOutput(.didChangeWatchlistStatus(isInWatchlist: isInWatchlist))
		}
	}
}
