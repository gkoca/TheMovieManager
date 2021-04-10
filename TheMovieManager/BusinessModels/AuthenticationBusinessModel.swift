//
//  AuthenticationBusinessModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation

protocol AuthenticationBusinessModelProtocol: BaseBusinessModelProtocol {
	var delegate: AuthenticationBusinessModelDelegate? { get set }
	func login(username: String, password: String)
}

protocol AuthenticationBusinessModelDelegate: BaseBusinessModelDelegate {
	func handleOutput(_ output: AuthenticationBusinessModelOutput)
}

enum AuthenticationBusinessModelOutput {
	case loginFailed(message: String)
	case loginSuccess
}

final class AuthenticationBusinessModel: BaseBusinessModel {
	
	weak var delegate: AuthenticationBusinessModelDelegate? {
		get {
			return self.baseDelegate as? AuthenticationBusinessModelDelegate
		}
		set {
			self.baseDelegate = newValue
		}
	}
	
	deinit {
		LOG("\(#function) \(String(describing: self))")
	}
}

// MARK: - AuthenticationBusinessModelProtocol methods
extension  AuthenticationBusinessModel:  AuthenticationBusinessModelProtocol {
	func login(username: String, password: String) {
		TMDBHelper.shared.createRequestToken { [weak self] (isSuccess, responseMessage) in
			if isSuccess {
				API.validateWithLogin(
					userName: username,
					password: password,
					requestToken: responseMessage).call { (response: CreateRequestTokenResponse?, error) in
						if response?.success ?? false, let token = response?.token {
							TMDBHelper.shared.createSession(with: token) { (isSuccess2, responseMessage2) in
								if isSuccess {
									self?.delegate?.handleOutput(.loginSuccess)
								} else {
									self?.delegate?.handleOutput(.loginFailed(message: responseMessage2))
								}
							}
						} else {
							self?.delegate?.handleOutput(.loginFailed(message: response?.statusMessage ?? "unknown error"))
						}
					}
			} else {
				self?.delegate?.handleOutput(.loginFailed(message: responseMessage))
			}
		}
	}
}
