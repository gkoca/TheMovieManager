//
//  DetailContracts.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

// MARK: Presenter
protocol DetailPresentationModelProtocol: BasePresentationModelProtocol {
	var viewController: DetailViewControllerProtocol? { get set }
	var router: DetailRouterProtocol? { get set }
	var item: MovieItem { get }
	func navigate(_ route: DetailRoutes)
	func changeFavoriteStatus()
	func changeWatchlistStatus()
	func isItemInFavorites() -> Bool
	func isItemInWatchlist() -> Bool
}

enum DetailPresentationModelOutput {
	case didChangeFavoriteStatus(isInFavorites: Bool)
	case didChangeWatchlistStatus(isInWatchlist: Bool)
}

// MARK: View
protocol DetailViewControllerProtocol: BaseViewControllerProtocol {
	var presentationModel: DetailPresentationModelProtocol? { get set }
	func handleOutput(_ output: DetailPresentationModelOutput)
}

// MARK: Router
protocol DetailRouterProtocol: BaseRouterProtocol {
	func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
	
}
