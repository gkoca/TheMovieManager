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
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	

	// MARK: - members

	// MARK: - initialize
	override func viewDidLoad() {
		super.viewDidLoad()
		presentationModel?.viewDidLoad()
	}

	// MARK: - custom methods
	
	@IBAction func loginButtonAction(_ sender: UIButton) {
		
	}
	
	
	@IBAction func loginViaWebButtonAction(_ sender: UIButton) {
		
	}
	
	
	deinit {
		LOG("\(#function) \(String(describing: self))")
	}
}

// MARK:- LoginViewControllerProtocol methods
extension LoginViewController: LoginViewControllerProtocol {
	func handleOutput(_ output:  LoginPresentationModelOutput) {
		switch output {
		}
	}
}
