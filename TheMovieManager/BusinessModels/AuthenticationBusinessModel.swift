//
//  AuthenticationBusinessModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation

protocol AuthenticationBusinessModelProtocol: BaseBusinessModelProtocol {
	var delegate: AuthenticationBusinessModelDelegate? { get set }
	func createRequestToken(completion: @escaping (Bool, String) -> Void)
	func createSession(with token: String, completion: @escaping (Bool, String) -> Void)
	func login(username: String, password: String)
	func logout()
}

protocol AuthenticationBusinessModelDelegate: BaseBusinessModelDelegate {
	func handleOutput(_ output: AuthenticationBusinessModelOutput)
}

enum AuthenticationBusinessModelOutput {
	case loginFailed(message: String)
	case loginSuccess
	case logoutFailed(message: String)
	case logoutSuccess
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
}

// MARK: - AuthenticationBusinessModelProtocol methods
extension  AuthenticationBusinessModel:  AuthenticationBusinessModelProtocol {
	
	func createRequestToken(completion: @escaping (Bool, String) -> Void) {
		API.createRequestToken.call { (response: CreateRequestTokenResponse?, error) in
			if let token = response?.token {
				completion(true, token)
			} else {
				let responseMessage = response?.statusMessage ?? error?.localizedDescription ?? "unknown error"
				completion(false, responseMessage)
			}
		}
	}
	
	func createSession(with token: String, completion: @escaping (Bool, String) -> Void) {
		API.createSession(requestToken: token).call { [weak self] (response: CreateSessionResponse?, error) in
			if response?.success ?? false, let sessionId = response?.sessionId {
				AppContext.main.sessionId = sessionId
				self?.getAccount(sessionId: sessionId, completion: { (isSuccess, responseMessage) in
					if isSuccess {
						completion(true, sessionId)
					} else {
						completion(false, responseMessage)
					}
				})
			} else {
				let responseMessage = response?.statusMessage ?? error?.localizedDescription ?? "unknown error"
				completion(false, responseMessage)
			}
		}
	}
	
	func logout() {
		guard let sessionId = AppContext.main.sessionId else {
			delegate?.handleOutput(.logoutFailed(message: "Session id is nil"))
			return
		}
		API.deleteSession(sessionId: sessionId).call { [weak self] (response: BaseResponse?, error) in
			if response?.success ?? false {
				AppContext.main.sessionId = nil
				AppContext.main.accountId = nil
				self?.delegate?.handleOutput(.logoutSuccess)
			} else {
				self?.delegate?.handleOutput(.logoutFailed(message: response?.statusMessage ?? error?.localizedDescription ?? "Unknown error"))
			}
		}
	}
	
	func login(username: String, password: String) {
		createRequestToken { [weak self] (isSuccess, responseMessage) in
			guard isSuccess else {
				self?.delegate?.handleOutput(.loginFailed(message: responseMessage))
				return
			}
			API.validateWithLogin(
				userName: username,
				password: password,
				requestToken: responseMessage).call { (response: CreateRequestTokenResponse?, error) in
					if response?.success ?? false, let token = response?.token {
						self?.createSession(with: token) { (isSuccess2, responseMessage2) in
							if isSuccess {
								self?.getAccount(sessionId: responseMessage2,completion: { (isSucceess, responseMessage3) in
									if isSuccess {
										self?.delegate?.handleOutput(.loginSuccess)
									} else {
										self?.delegate?.handleOutput(.loginFailed(message: responseMessage3))
									}
								})
							} else {
								self?.delegate?.handleOutput(.loginFailed(message: responseMessage2))
							}
						}
					} else {
						self?.delegate?.handleOutput(.loginFailed(message: response?.statusMessage ?? error?.localizedDescription ?? "unknown error"))
					}
				}
		}
	}
	
	private func getAccount(sessionId: String, completion: @escaping (Bool, String) -> Void) {
		API.account(sessionId: sessionId).call { (response: Account?, error) in
			if let id = response?.id {
				AppContext.main.accountId = id
				FavoritesAndWatchlistManager.shared.load {
					completion(true,"\(id)")
				}
			} else {
				completion(false, response?.statusMessage ?? error?.localizedDescription ?? "unknown error")
			}
		}
	}
}
