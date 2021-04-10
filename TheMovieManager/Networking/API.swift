//
//  API.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

enum API: Caller {
	
	case createRequestToken
	case createSession(requestToken: String)
	
	var apiKey: String? {
		return Bundle.main.infoForKey("API_KEY")
	}
	
	var baseURL: URL {
		let baseURLString = Bundle.main.infoForKey("BASE_URL") ?? ""
		return URL(forceString: baseURLString)
	}
	
	var path: String {
		switch self {
		case .createRequestToken:
			return "/authentication/token/new"
		case .createSession:
			return "/authentication/session/new"
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .createRequestToken:
			return .get
		case .createSession:
			//			return .post // api documentation says that this request should be `post` but apparently it is not
			return .get
		}
	}
	
	var parameters: [String : Any] {
		switch self {
		case .createSession(let token):
			return ["request_token":token]
		default:
			return [:]
		}
	}
	
	var task: HTTPTask {
		switch self {
		case .createRequestToken:
			return .requestParameters(parameters: parameters, encoding: .urlEncoding)
		case .createSession:
			//			return .requestParameters(parameters: parameters, encoding: .jsonEncoding)
			return .requestParameters(parameters: parameters, encoding: .urlEncoding)
		}
	}
	
	var mock: Data? {
		return nil
	}
}
