//
//  LoginContracts.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation

// MARK: Presenter
protocol LoginPresentationModelProtocol: BasePresentationModelProtocol {
	var viewController: LoginViewControllerProtocol? { get set }
	var router: LoginRouterProtocol? { get set }
	func navigate(_ route: LoginRoutes)
	func viewDidLoad()
}

enum LoginPresentationModelOutput {
	
}

// MARK: View
protocol LoginViewControllerProtocol: BaseViewControllerProtocol {
	var presentationModel: LoginPresentationModelProtocol? { get set }
	func handleOutput(_ output: LoginPresentationModelOutput)
}

// MARK: Router
protocol LoginRouterProtocol: BaseRouterProtocol {
	func navigate(_ route: LoginRoutes)
}

enum LoginRoutes {
	
}
