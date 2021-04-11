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
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	// MARK: - initialize
	override func viewDidLoad() {
		super.viewDidLoad()
		#if DEBUG
		usernameTextField.text = "amatur"
		passwordTextField.text = "amatur123"
		#endif
	}
	
	// MARK: - custom methods
	@IBAction func loginButtonAction(_ sender: UIButton) {
		if let username = usernameTextField.text, let password = passwordTextField.text {
			usernameTextField.resignFirstResponder()
			passwordTextField.resignFirstResponder()
			presentationModel?.login(username: username, password: password)
		}
	}
	
	@IBAction func loginViaWebButtonAction(_ sender: UIButton) {
		presentationModel?.presentWebLogin()
	}
}

// MARK:- LoginViewControllerProtocol methods
extension LoginViewController: LoginViewControllerProtocol {
	func handleOutput(_ output:  LoginPresentationModelOutput) {
		switch output {
		}
	}
}
