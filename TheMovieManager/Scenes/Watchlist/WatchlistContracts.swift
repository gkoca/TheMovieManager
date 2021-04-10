//
//  WatchlistContracts.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

// MARK: Presenter
protocol WatchlistPresentationModelProtocol: BasePresentationModelProtocol {
	var viewController: WatchlistViewControllerProtocol? { get set }
	var router: WatchlistRouterProtocol? { get set }
	func navigate(_ route: WatchlistRoutes)
}

enum WatchlistPresentationModelOutput {
	
}

// MARK: View
protocol WatchlistViewControllerProtocol: BaseViewControllerProtocol {
	var presentationModel: WatchlistPresentationModelProtocol? { get set }
	func handleOutput(_ output: WatchlistPresentationModelOutput)
}

// MARK: Router
protocol WatchlistRouterProtocol: BaseRouterProtocol {
	func navigate(_ route: WatchlistRoutes)
}

enum WatchlistRoutes {
	
}
