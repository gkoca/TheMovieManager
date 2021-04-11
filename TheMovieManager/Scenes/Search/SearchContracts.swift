//
//  SearchContracts.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

// MARK: Presenter
protocol SearchPresentationModelProtocol: BasePresentationModelProtocol {
	var viewController: SearchViewControllerProtocol? { get set }
	var router: SearchRouterProtocol? { get set }
	var items: [MovieItem] { get }
	func navigate(_ route: SearchRoutes)
	func logout()
	func search(query: String)
	func loadMore()
	func didSelectItem(at index: Int)
}

enum SearchPresentationModelOutput {
	case didGetMovies(isFresh: Bool)
}

// MARK: View
protocol SearchViewControllerProtocol: BaseViewControllerProtocol {
	var presentationModel: SearchPresentationModelProtocol? { get set }
	func handleOutput(_ output: SearchPresentationModelOutput)
}

// MARK: Router
protocol SearchRouterProtocol: BaseRouterProtocol {
	func navigate(_ route: SearchRoutes)
}

enum SearchRoutes {
	case logout
	case detail(item: MovieItem)
}
