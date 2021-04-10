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
	func presentWebLogin()
	func login(username: String, password: String)
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
	case webLogin(token: String, delegate: LoginViaWebSceneDelegate?)
	case main
}

enum LoginProcessType {
	case none
	case web
	case app
}
