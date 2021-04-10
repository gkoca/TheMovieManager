//
//  API.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

enum API: Caller {
	
	case token
	
	var apiKey: String? {
		return Bundle.main.infoForKey("API_KEY")
	}
	
	var baseURL: URL {
		let baseURLString = Bundle.main.infoForKey("BASE_URL") ?? ""
		return URL(forceString: baseURLString)
	}
	
	var path: String {
		switch self {
		case .token:
			return "/authentication/token/new"
		
		}
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var parameters: [String : Any] {
		return [:]
	}
	
	var task: HTTPTask {
		return .requestParameters(parameters: parameters, encoding: .urlEncoding)
	}
	
	var mock: Data? {
		return nil
	}
	

}
