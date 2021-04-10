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
	
	func createRequestToken(completion: @escaping (Bool, String?) -> Void) {
		API.createRequestToken.call { (response: CreateRequestTokenResponse?, error) in
			if let token = response?.token {
				completion(true, token)
			} else {
				completion(false, nil)
			}
		}
	}
	
	func createSession(with token: String, completion: @escaping (Bool) -> Void) {
		API.createSession(requestToken: token).call { (response: CreateSessionResponse?, error) in
			if response?.success ?? false, let sessionId = response?.sessionId {
				self.sessionId = sessionId
				completion(true)
			} else {
				completion(false)
			}
		}
	}
}
