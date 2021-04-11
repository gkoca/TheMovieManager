//
//  ResponseModels.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

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
