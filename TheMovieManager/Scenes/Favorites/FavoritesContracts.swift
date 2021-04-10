//
//  FavoritesContracts.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

// MARK: Presenter
protocol FavoritesPresentationModelProtocol: BasePresentationModelProtocol {
	var viewController: FavoritesViewControllerProtocol? { get set }
	var router: FavoritesRouterProtocol? { get set }
	func navigate(_ route: FavoritesRoutes)
}

enum FavoritesPresentationModelOutput {
	
}

// MARK: View
protocol FavoritesViewControllerProtocol: BaseViewControllerProtocol {
	var presentationModel: FavoritesPresentationModelProtocol? { get set }
	func handleOutput(_ output: FavoritesPresentationModelOutput)
}

// MARK: Router
protocol FavoritesRouterProtocol: BaseRouterProtocol {
	func navigate(_ route: FavoritesRoutes)
}

enum FavoritesRoutes {
	
}
