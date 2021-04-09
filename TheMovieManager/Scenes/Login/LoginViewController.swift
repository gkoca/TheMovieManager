//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

final class LoginViewController: BaseViewController {
	var presentationModel: LoginPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? LoginPresentationModelProtocol
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
	
	deinit {
		print("\(#function) \(String(describing: self))")
	}
}

// MARK:- LoginViewControllerProtocol methods
extension LoginViewController: LoginViewControllerProtocol {
	func handleOutput(_ output:  LoginPresentationModelOutput) {
		switch output {
		}
	}
}
