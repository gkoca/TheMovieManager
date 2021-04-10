//
//  LoginViaWebContracts.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

// MARK: Presenter
protocol LoginViaWebPresentationModelProtocol: BasePresentationModelProtocol {
	var viewController: LoginViaWebViewControllerProtocol? { get set }
	var router: LoginViaWebRouterProtocol? { get set }
	var authenticationURL: URL { get }
	var requestToken: String { get }
	func navigate(_ route: LoginViaWebRoutes)
	func createSession()
	func viewDidDisappear()
}

enum LoginViaWebPresentationModelOutput {
	case sessionCreated
}

// MARK: View
protocol LoginViaWebViewControllerProtocol: BaseViewControllerProtocol {
	var presentationModel: LoginViaWebPresentationModelProtocol? { get set }
	func handleOutput(_ output: LoginViaWebPresentationModelOutput)
}

// MARK: Router
protocol LoginViaWebRouterProtocol: BaseRouterProtocol {
	func navigate(_ route: LoginViaWebRoutes)
}

enum LoginViaWebRoutes {
	
}

protocol LoginViaWebSceneDelegate: class {
	func sessionCreated()
	func sceneDidDisappear()
}
