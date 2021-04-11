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

/*
{
  "page": 1,
  "results": [
	{
	  "poster_path": "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
	  "adult": false,
	  "overview": "When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!",
	  "release_date": "2012-04-25",
	  "genre_ids": [
		878,
		28,
		12
	  ],
	  "id": 24428,
	  "original_title": "The Avengers",
	  "original_language": "en",
	  "title": "The Avengers",
	  "backdrop_path": "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
	  "popularity": 7.353212,
	  "vote_count": 8503,
	  "video": false,
	  "vote_average": 7.33
	},
	{
	  "poster_path": "/pMdTc3kYCD1869UX6cdYUT8Xe49.jpg",
	  "adult": false,
	  "overview": "Feature-length documentary about the rise of Marvel Studios and their films leading up to, and including, The Avengers.",
	  "release_date": "2012-09-25",
	  "genre_ids": [
		99
	  ],
	  "id": 161097,
	  "original_title": "Marvel Studios: Building a Cinematic Universe",
	  "original_language": "en",
	  "title": "Marvel Studios: Building a Cinematic Universe",
	  "backdrop_path": "/yeKT2gNFxHGbTT3Htj5PE9IerGJ.jpg",
	  "popularity": 1.136598,
	  "vote_count": 4,
	  "video": false,
	  "vote_average": 3.88
	}
  ],
  "total_results": 14,
  "total_pages": 1
}
*/
