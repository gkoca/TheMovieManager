//
//  AuthenticationBusinessModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation

protocol AuthenticationBusinessModelProtocol: BaseBusinessModelProtocol {
	var delegate: AuthenticationBusinessModelDelegate? { get set }
	func getNewToken()
}

protocol AuthenticationBusinessModelDelegate: BaseBusinessModelDelegate {
	func handleOutput(_ output: AuthenticationBusinessModelOutput)
}

enum AuthenticationBusinessModelOutput {
	case didGetToken(token: String, expiration: Date)
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
	func getNewToken() {
		API.newToken.call { [weak self] (response: TokenResponse?, error) in
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
			if let token = response?.token,
			   let expiration = response?.expiration,
			   let expirationDate = formatter.date(from: expiration) {
				AppContext.main.requestToken = token
				AppContext.main.requestTokenExpiration = expirationDate
				self?.delegate?.handleOutput(.didGetToken(token: token, expiration: expirationDate))
			}
		}
	}
}
