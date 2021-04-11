//
//  MainContracts.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

// MARK: Presenter
protocol MainPresentationModelProtocol: BasePresentationModelProtocol {
	var viewController: MainViewControllerProtocol? { get set }
	var router: MainRouterProtocol? { get set }
	func navigate(_ route: MainRoutes)
	func logout()
}

enum MainPresentationModelOutput {
	case didLoadScenes(search: SearchViewController,
					   watchlist: WatchlistViewController,
					   favorites: FavoritesViewController)
}

// MARK: View
protocol MainViewControllerProtocol: BaseViewControllerProtocol {
	var presentationModel: MainPresentationModelProtocol? { get set }
	func handleOutput(_ output: MainPresentationModelOutput)
}

// MARK: Router
protocol MainRouterProtocol: BaseRouterProtocol {
	func navigate(_ route: MainRoutes)
}

enum MainRoutes {
	case logout
}
