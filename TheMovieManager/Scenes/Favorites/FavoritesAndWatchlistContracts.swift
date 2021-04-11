//
//  FavoritesAndWatchlistContracts.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

// MARK: Presenter
protocol FavoritesAndWatchlistPresentationModelProtocol: BasePresentationModelProtocol {
	var viewController: FavoritesAndWatchlistViewControllerProtocol? { get set }
	var router: FavoritesAndWatchlistRouterProtocol? { get set }
	var mode: FavoritesAndWatchlistSceneMode { get }
	var items: [MovieItem] { get }
	func navigate(_ route: FavoritesAndWatchlistRoutes)
	func didSelectItem(at index: Int)
}

enum FavoritesAndWatchlistPresentationModelOutput {
	case shouldReload
}

// MARK: View
protocol FavoritesAndWatchlistViewControllerProtocol: BaseViewControllerProtocol {
	var presentationModel: FavoritesAndWatchlistPresentationModelProtocol? { get set }
	func handleOutput(_ output: FavoritesAndWatchlistPresentationModelOutput)
}

// MARK: Router
protocol FavoritesAndWatchlistRouterProtocol: BaseRouterProtocol {
	func navigate(_ route: FavoritesAndWatchlistRoutes)
}

enum FavoritesAndWatchlistRoutes {
	case detail(item: MovieItem)
}

enum FavoritesAndWatchlistSceneMode {
	case favorites
	case watchlist
}
