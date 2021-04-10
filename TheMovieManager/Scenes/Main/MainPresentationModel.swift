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
	var sceneLoadingHandler: (() -> Void)?

	// MARK: - initialize with businessModel(s)
	override init() {
		super.init()
	}

	/// you should fire ´sceneLoadingHandler´ after loading process completed. 
	/// if you don't have loading process, you may send ´viewController´ directly via ´completion´
	func loadScene(completion: @escaping ((MainViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let viewController: MainViewController = storyBoard.instantiateViewController()
		let router = MainRouter(viewController: viewController)
		self.viewController = viewController
		self.router = router
		viewController.presentationModel = self
		viewController.loadViewIfNeeded()
//		sceneLoadingHandler = {
			completion(viewController)
//		}
		// start loading process here
	} 
}

// MARK: - MainPresentationModelProtocol methods
extension MainPresentationModel: MainPresentationModelProtocol {
	func navigate(_ route: MainRoutes) {
		router?.navigate(route)
	}
}

// Conform businessModelDelegates
// MARK: - BusinessModelDelegate methods

