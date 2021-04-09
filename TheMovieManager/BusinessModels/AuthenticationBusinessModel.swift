//
//  AuthenticationBusinessModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation

protocol AuthenticationBusinessModelProtocol: BaseBusinessModelProtocol {
	var delegate: AuthenticationBusinessModelDelegate? { get set }
}

protocol AuthenticationBusinessModelDelegate: BaseBusinessModelDelegate {
	func handleOutput(_ output: AuthenticationBusinessModelOutput)
}

enum AuthenticationBusinessModelOutput {
	
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
	
}
