//
//  TMDBHelper.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

class TMDBHelper {
	
	static let shared = TMDBHelper()
	
	var sessionId: String?
	
	func createRequestToken(completion: @escaping (Bool, String) -> Void) {
		API.createRequestToken.call { (response: CreateRequestTokenResponse?, error) in
			if let token = response?.token {
				completion(true, token)
			} else {
				let responseMessage = response?.statusMessage ?? "unknown error"
				completion(false, responseMessage)
			}
		}
	}
	
	func createSession(with token: String, completion: @escaping (Bool, String) -> Void) {
		API.createSession(requestToken: token).call { (response: CreateSessionResponse?, error) in
			if response?.success ?? false, let sessionId = response?.sessionId {
				self.sessionId = sessionId
				completion(true, sessionId)
			} else {
				let responseMessage = response?.statusMessage ?? "unknown error"
				completion(false, responseMessage)
			}
		}
	}
}
