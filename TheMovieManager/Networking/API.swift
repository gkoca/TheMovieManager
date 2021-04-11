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
	case validateWithLogin(userName: String, password: String, requestToken: String)
	case deleteSession(sessionId: String)
	
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
		case .validateWithLogin:
			return "authentication/token/validate_with_login"
		case .deleteSession:
			return "/authentication/session"
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .createRequestToken:
			return .get
		case .createSession:
			// return .post // api documentation says that this request should be `post` but apparently it is not
			return .get
		case .validateWithLogin:
			// return .post
			// https://www.themoviedb.org/talk/5eb5da430cb3350020cbf669#last
			// this is major api issue. api does not provide post request for login **facepalm**
			return .get
		case .deleteSession:
			return .delete
		}
	}
	
	var parameters: [String : Any] {
		switch self {
		case .createSession(let token):
			return ["request_token":token]
		case .validateWithLogin(let userName, let password, let token):
			return [
				"request_token":token,
				"username" : userName,
				"password": password
			]
		case .deleteSession(let sessionId):
			return [
				"session_id" : sessionId
			]
		default:
			return [:]
		}
	}
	
	var task: HTTPTask {
		switch self {
		case .createRequestToken:
			return .requestParameters(parameters: parameters, encoding: .urlEncoding)
		case .createSession:
			// return .requestParameters(parameters: parameters, encoding: .jsonEncoding)
			return .requestParameters(parameters: parameters, encoding: .urlEncoding)
		case .validateWithLogin:
			// return .requestParameters(parameters: parameters, encoding: .jsonEncoding)
			return .requestParameters(parameters: parameters, encoding: .urlEncoding)
		case .deleteSession:
			return .requestParameters(parameters: parameters, encoding: .jsonEncoding)
		}
	}
	
	var mock: Data? {
		return nil
	}
}
