//
//  ResponseModels.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation
/*
{
  "success": true,
  "expires_at": "2016-08-26 17:04:39 UTC",
  "request_token": "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd"
}

{
  "success": true,
  "session_id": "79191836ddaa0da3df76a5ffef6f07ad6ab0c641"
}
*/

struct CreateRequestTokenResponse: Decodable {
	let success: Bool?
	let expiration: String?
	let token: String?
	
	enum CodingKeys: String, CodingKey {
		case success
		case expiration = "expires_at"
		case token = "request_token"
	}
}

struct CreateSessionResponse: Decodable {
	let success: Bool?
	let sessionId: String?
	
	enum CodingKeys: String, CodingKey {
		case success
		case sessionId = "session_id"
	}
}
