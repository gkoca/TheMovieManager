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
	}

	
	// MARK: - custom methods
}

// MARK:- MainViewControllerProtocol methods
extension MainViewController: MainViewControllerProtocol {
	func handleOutput(_ output:  MainPresentationModelOutput) {
		switch output {
		}
	}
}
