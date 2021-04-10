//
//  BaseViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

class BaseViewController: UIViewController {
	
	internal var basePresentationModel: BasePresentationModelProtocol?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		LOG("\(String(describing: type(of: self))) \(#function)")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		LOG("\(String(describing: type(of: self))) \(#function)")
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		LOG("\(String(describing: type(of: self))) \(#function)")
	}
	
	deinit {
		LOG("\(String(describing: type(of: self))) \(#function)")
	}
}

extension BaseViewController: BaseViewControllerProtocol {
	func didFailure(errorText: String) {
		LOG("\(String(describing: type(of: self))) \(#function) text: \(errorText)")
		let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default))
		present(alert, animated: true)
	}
	
	func hideKeyboard() {
		LOG("\(String(describing: type(of: self))) \(#function)")
	}
}

