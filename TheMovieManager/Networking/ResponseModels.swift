//
//  ResponseModels.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

struct CreateRequestTokenResponse: Decodable {
	let success: Bool?
	let expiration: String?
	let token: String?
	let statusMessage: String?
	
	enum CodingKeys: String, CodingKey {
		case success
		case expiration = "expires_at"
		case token = "request_token"
		case statusMessage = "status_message"
	}
}

struct CreateSessionResponse: Decodable {
	let success: Bool?
	let sessionId: String?
	let statusMessage: String?
	
	enum CodingKeys: String, CodingKey {
		case success
		case sessionId = "session_id"
		case statusMessage = "status_message"
	}
}
