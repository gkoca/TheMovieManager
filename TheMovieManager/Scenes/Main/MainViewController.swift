//
//  MainViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class MainViewController: BaseTabbarController {
	var presentationModel: MainPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? MainPresentationModelProtocol
		}
		set {
			self.basePresentationModel = newValue
		}
	}

	// MARK: - ui controls

	// MARK: - members

	// MARK: - initialize
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigationBar()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		title = tabBar.items?.first?.title
	}

	// MARK: - custom methods
	func setupNavigationBar() { //UIBarButtonItem(title: "Add", style: .plain,
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonAction))
	}
	
	@objc func logoutButtonAction() {
		presentationModel?.logout()
	}
	
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		title = item.title
	}
}

// MARK:- MainViewControllerProtocol methods
extension MainViewController: MainViewControllerProtocol {
	func handleOutput(_ output:  MainPresentationModelOutput) {
		switch output {
		case .didLoadScenes(let search, let watchlist, let favorites):
			viewControllers = [search, watchlist, favorites]
		}
	}
}
