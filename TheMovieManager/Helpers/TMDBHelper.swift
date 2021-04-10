//
//  TMDBHelper.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

class TMDBHelper {
	
	static let shared = TMDBHelper()
	
	func getNewRequestToken(completion: @escaping (Bool, String?) -> Void) {
		API.newToken.call { (response: TokenResponse?, error) in
			if let token = response?.token {
				completion(true, token)
			} else {
				completion(false, nil)
			}
		}
	}
}
