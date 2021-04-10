//
//  LoginViaWebViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class LoginViaWebViewController: BaseViewController {
	var presentationModel: LoginViaWebPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? LoginViaWebPresentationModelProtocol
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

// MARK:- LoginViaWebViewControllerProtocol methods
extension LoginViaWebViewController: LoginViaWebViewControllerProtocol {
	func handleOutput(_ output:  LoginViaWebPresentationModelOutput) {
		switch output {
		}
	}
}
