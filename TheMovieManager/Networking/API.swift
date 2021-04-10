//
//  API.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

enum API: Caller {
	
	case newToken
	case newSession(requestToken: String)
	
	var apiKey: String? {
		return Bundle.main.infoForKey("API_KEY")
	}
	
	var baseURL: URL {
		let baseURLString = Bundle.main.infoForKey("BASE_URL") ?? ""
		return URL(forceString: baseURLString)
	}
	
	var path: String {
		switch self {
		case .newToken:
			return "/authentication/token/new"
		case .newSession:
			return "/authentication/session/new"
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .newToken:
			return .get
		case .newSession:
			return .post
		}
	}
	
	var parameters: [String : Any] {
		switch self {
		case .newSession(let token):
			return ["request_token":token]
		default:
			return [:]
		}
	}
	
	var task: HTTPTask {
		switch self {
		case .newToken:
			return .requestParameters(parameters: parameters, encoding: .urlEncoding)
		case .newSession:
			return .requestParameters(parameters: parameters, encoding: .jsonEncoding)
		}
	}
	
	var mock: Data? {
		return nil
	}
	

}
