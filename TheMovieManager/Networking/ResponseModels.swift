//
//  ResponseModels.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

class BaseResponse: Decodable {
	let success: Bool?
	let statusCode: Int?
	let statusMessage: String?
	
	enum CodingKeys: String, CodingKey {
		case success
		case statusCode = "status_code"
		case statusMessage = "status_message"
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		success = try container.decodeIfPresent(Bool.self, forKey: .success)
		statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
		statusMessage = try container.decodeIfPresent(String.self, forKey: .statusMessage)
	}
}

class CreateRequestTokenResponse: BaseResponse {
	var expiration: String?
	var token: String?
	
	enum CodingKeys: String, CodingKey {
		case expiration = "expires_at"
		case token = "request_token"
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		try super.init(from: decoder)
		expiration = try container.decodeIfPresent(String.self, forKey: .expiration)
		token = try container.decodeIfPresent(String.self, forKey: .token)
	}
}

class CreateSessionResponse: BaseResponse {
	var sessionId: String?
	
	enum CodingKeys: String, CodingKey {
		case sessionId = "session_id"
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		try super.init(from: decoder)
		sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
	}
}

class Account: BaseResponse {
	
	var id: Int?
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		try super.init(from: decoder)
		id = try container.decodeIfPresent(Int.self, forKey: .id)
	}
	
	enum CodingKeys: String, CodingKey {
		case id
	}
}

class MovieListResponse: BaseResponse {
	var page: Int = 1
	var results: [MovieItem] = []
	var totalResults: Int = 0
	var totalPages: Int = 1
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		try super.init(from: decoder)
		page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 1
		results = try container.decodeIfPresent([MovieItem].self, forKey: .results) ?? []
		totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
		totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) ?? 1
	}
	
	enum CodingKeys: String, CodingKey {
		case page
		case results
		case totalResults = "total_results"
		case totalPages = "total_pages"
	}
}

class MovieItem: NSObject, Decodable {
	let id: Int?
	let poster_path: String?
	let backdrop_path: String?
	let title: String?
	let vote_average: Double?
	let release_date: String?
	let overview: String?
}
