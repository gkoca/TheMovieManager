//
//  WatchlistViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class WatchlistViewController: BaseViewController {
	var presentationModel: WatchlistPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? WatchlistPresentationModelProtocol
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
		title = "Watchlist"
		let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
		tabBarItem.image = UIImage(systemName: "list.bullet", withConfiguration: lightConfiguration)
	}

	// MARK: - custom methods
}

// MARK:- WatchlistViewControllerProtocol methods
extension WatchlistViewController: WatchlistViewControllerProtocol {
	func handleOutput(_ output:  WatchlistPresentationModelOutput) {
		switch output {
		}
	}
}
