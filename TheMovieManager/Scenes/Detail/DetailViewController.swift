//
//  DetailViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class DetailViewController: BaseViewController {
	var presentationModel: DetailPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? DetailPresentationModelProtocol
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

// MARK:- DetailViewControllerProtocol methods
extension DetailViewController: DetailViewControllerProtocol {
	func handleOutput(_ output:  DetailPresentationModelOutput) {
		switch output {
		}
	}
}
