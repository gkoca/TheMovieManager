//
//  SearchPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class SearchPresentationModel: BasePresentationModel {
	
	weak var viewController: SearchViewControllerProtocol? {
		get {
			return self.baseViewController as? SearchViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: SearchRouterProtocol? {
		get {
			return self.baseRouter as?  SearchRouterProtocol
		}
		set {
			self.baseRouter = newValue
		}
	}
	var items: [MovieItem] = []
	var searchBusinessModel: SearchMovieBusinessModelProtocol
	var authBusinessModel: AuthenticationBusinessModelProtocol
	var sceneLoadingHandler: (() -> Void)?
	var currentPage = 1
	var currentQuery = ""
	var totalPage = 1
	
	// MARK: - initialize with businessModel(s)
	init(authentication: AuthenticationBusinessModelProtocol, search: SearchMovieBusinessModelProtocol) {
		authBusinessModel = authentication
		searchBusinessModel = search
		super.init()
		authBusinessModel.delegate = self
		searchBusinessModel.delegate = self
	}

	func loadScene(completion: @escaping ((SearchViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Search", bundle: nil)
		var viewController: SearchViewController? = storyBoard.instantiateViewController()
		let router = SearchRouter(viewController: viewController!)
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

// MARK: - SearchPresentationModelProtocol methods
extension SearchPresentationModel: SearchPresentationModelProtocol {
	func search(query: String) {
		currentPage = 1
		totalPage = 1
		currentQuery = query
		searchBusinessModel.search(page: currentPage, query: query)
	}
	
	func loadMore() {
		if currentPage < totalPage {
			currentPage += 1
			searchBusinessModel.search(page: currentPage, query: currentQuery)
		}
	}
	
	func logout() {
		authBusinessModel.logout()
	}
	
	func navigate(_ route: SearchRoutes) {
		router?.navigate(route)
	}
}

// MARK: - BusinessModelDelegate methods
extension SearchPresentationModel: AuthenticationBusinessModelDelegate {
	func handleOutput(_ output: AuthenticationBusinessModelOutput) {
		switch output {
		case .logoutFailed(let message):
			viewController?.didFailure(errorText: message)
		case .logoutSuccess:
			navigate(.logout)
		default:
			break
		}
	}
}

extension SearchPresentationModel: SearchMovieBusinessModelDelegate {
	func handleOutput(_ output: SearchMovieBusinessModelOutput) {
		switch output {
		case .didGetSearchResult(let page, let items, let total):
			totalPage = total
			var isFresh = true
			if page > 1 {
				self.items.append(contentsOf: items)
				isFresh = false
			} else {
				self.items = items
			}
			viewController?.handleOutput(.didGetMovies(isFresh: isFresh))
		}
	}
}
