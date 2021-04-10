//
//  DetailPresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class DetailPresentationModel: BasePresentationModel {
	
	weak var viewController: DetailViewControllerProtocol? {
		get {
			return self.baseViewController as? DetailViewControllerProtocol
		}
		set {
			self.baseViewController = newValue
		}
	}
	var router: DetailRouterProtocol? {
		get {
			return self.baseRouter as?  DetailRouterProtocol
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
	func loadScene(completion: @escaping ((DetailViewController) -> Void)) {
		let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
		let viewController: DetailViewController = storyBoard.instantiateViewController()
		let router = DetailRouter(viewController: viewController)
		self.viewController = viewController
		self.router = router
		viewController.presentationModel = self
		viewController.loadViewIfNeeded()
		sceneLoadingHandler = {
			completion(viewController)
		}
		// start loading process here
	} 
}

// MARK: - DetailPresentationModelProtocol methods
extension DetailPresentationModel: DetailPresentationModelProtocol {
	func navigate(_ route: DetailRoutes) {
		router?.navigate(route)
	}
}

// Conform businessModelDelegates
// MARK: - BusinessModelDelegate methods

