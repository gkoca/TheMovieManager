//
//  SearchViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class SearchViewController: BaseViewController {
	var presentationModel: SearchPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? SearchPresentationModelProtocol
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
		title = "Search"
		let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
		tabBarItem.image = UIImage(systemName: "magnifyingglass", withConfiguration: lightConfiguration)
	}

	// MARK: - custom methods
}

// MARK:- SearchViewControllerProtocol methods
extension SearchViewController: SearchViewControllerProtocol {
	func handleOutput(_ output:  SearchPresentationModelOutput) {
		switch output {
		}
	}
}
