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
	func navigate(_ route: DetailRoutes)
}

enum DetailPresentationModelOutput {
	
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
