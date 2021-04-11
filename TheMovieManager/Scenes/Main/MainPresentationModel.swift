//
//  MainPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class MainPresentationModel: BasePresentationModel {
	
	weak var viewController: MainViewControllerProtocol? {
		get {
			return self.baseViewController as? MainViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: MainRouterProtocol? {
		get {
			return self.baseRouter as?  MainRouterProtocol
		}
		set {
			self.baseRouter = newValue
		}
	}
	
	var authentication: AuthenticationBusinessModelProtocol
	var sceneLoadingHandler: (() -> Void)?
	
	// MARK: - initialize with businessModel(s)
	init(with businessModel: AuthenticationBusinessModelProtocol) {
		authentication = businessModel
		super.init()
		authentication.delegate = self
	}
	
	deinit {
		LOG("\(String(describing: type(of: self))) \(#function)")
	}
	
	func loadScene(completion: @escaping ((MainViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		var viewController: MainViewController? = storyBoard.instantiateViewController()
		let router = MainRouter(viewController: viewController!)
		self.viewController = viewController
		self.router = router
		viewController?.presentationModel = self
		viewController?.loadViewIfNeeded()
		sceneLoadingHandler = {
			if let viewController = viewController {
				completion(viewController)
			}
			viewController = nil
		}
		createTabScenes()
	}
	
	func createTabScenes() {
		var search: UINavigationController?
		var watchlist: WatchlistViewController?
		var favorites: FavoritesViewController?
		
		let group = DispatchGroup()
		group.enter()
		SearchBuilder.build { (searchViewController) in
			let navController = UINavigationController(rootViewController: searchViewController)
			search = navController
			group.leave()
		}
		group.enter()
		WatchlistBuilder.build { (watchlistViewController) in
			watchlist = watchlistViewController
			group.leave()
		}
		group.enter()
		FavoritesBuilder.build { (favoritesViewController) in
			favorites = favoritesViewController
			group.leave()
		}
		
		group.notify(queue: .main) { [weak self] in
			guard let search = search, let watchlist = watchlist, let favorites = favorites else { return }
			self?.viewController?.handleOutput(.didLoadScenes(search: search, watchlist: watchlist, favorites: favorites))
			self?.sceneLoadingHandler?()
		}
	}
}

// MARK: - MainPresentationModelProtocol methods
extension MainPresentationModel: MainPresentationModelProtocol {
	func logout() {
		authentication.logout()
	}
	
	func navigate(_ route: MainRoutes) {
		router?.navigate(route)
	}
}

// MARK: - BusinessModelDelegate methods
extension MainPresentationModel:AuthenticationBusinessModelDelegate {
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
