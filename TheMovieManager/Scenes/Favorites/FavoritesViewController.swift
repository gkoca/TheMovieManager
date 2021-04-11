//
//  FavoritesViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class FavoritesViewController: BaseViewController {
	var presentationModel: FavoritesPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? FavoritesPresentationModelProtocol
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
		title = "Favorites"
		let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
		tabBarItem.image = UIImage(systemName: "star", withConfiguration: lightConfiguration)
		tabBarItem.selectedImage = UIImage(systemName: "star.fill", withConfiguration: lightConfiguration)
	}

	// MARK: - custom methods
}

// MARK:- FavoritesViewControllerProtocol methods
extension FavoritesViewController: FavoritesViewControllerProtocol {
	func handleOutput(_ output:  FavoritesPresentationModelOutput) {
		switch output {
		}
	}
}
