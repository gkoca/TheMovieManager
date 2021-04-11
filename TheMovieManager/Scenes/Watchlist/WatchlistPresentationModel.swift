//
//  WatchlistPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class WatchlistPresentationModel: BasePresentationModel {
	
	weak var viewController: WatchlistViewControllerProtocol? {
		get {
			return self.baseViewController as? WatchlistViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: WatchlistRouterProtocol? {
		get {
			return self.baseRouter as?  WatchlistRouterProtocol
		}
		set {
			self.baseRouter = newValue
		}
	}
	var sceneLoadingHandler: (() -> Void)?

	// MARK: - initialize with businessModel(s)
	override init() {
		super.init()
	}

	deinit {
		LOG("\(String(describing: type(of: self))) \(#function)")
	}
	
	/// you should fire ´sceneLoadingHandler´ after loading process completed. 
	/// if you don't have loading process, you may send ´viewController´ directly via ´completion´
	func loadScene(completion: @escaping ((WatchlistViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Watchlist", bundle: nil)
		var viewController: WatchlistViewController? = storyBoard.instantiateViewController()
		let router = WatchlistRouter(viewController: viewController!)
		self.viewController = viewController
		self.router = router
		viewController?.presentationModel = self
		viewController?.loadViewIfNeeded()
//		sceneLoadingHandler = {
		if let viewController = viewController {
			completion(viewController)
		}
		viewController = nil
//		}
		// start loading process here
	} 
}

// MARK: - WatchlistPresentationModelProtocol methods
extension WatchlistPresentationModel: WatchlistPresentationModelProtocol {
	func navigate(_ route: WatchlistRoutes) {
		router?.navigate(route)
	}
}

// Conform businessModelDelegates
// MARK: - BusinessModelDelegate methods

