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
	case account(sessionId: String)
	case search(page: Int, query: String)
	case favorites(page: Int, accountId: Int, sessionId: String)
	case favoriteFlag(accountId: Int, movieId: Int, isFavorite: Bool, sessionId: String)
	case watchlist(page: Int, accountId: Int, sessionId: String)
	case watchlistFlag(accountId: Int, movieId: Int, addWatchlist: Bool, sessionId: String)
	
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
		case .account:
			return "/account"
		case .search:
			return "/search/movie"
		case .favorites(_, let accountId, _):
			return "/account/\(accountId)/favorite/movies"
		case .favoriteFlag(let accountId, _, _, _):
			return "/account/\(accountId)/favorite"
		case .watchlist(_, let accountId, _):
			return "/account/\(accountId)/watchlist/movies"
		case .watchlistFlag(let accountId, _, _, _):
			return "/account/\(accountId)/watchlist"
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
		case .account:
			return .get
		case .search:
			return .get
		case .favorites, .watchlist:
			return .get
		case .favoriteFlag, .watchlistFlag:
			return .post
		}
	}
	
	var body: [String : Any]? {
		switch self {
		case .deleteSession(let sessionId):
			return [
				"session_id" : sessionId
			]
		case .favoriteFlag(_, let movieId, let isFavorite, _):
			return [
				"media_type": "movie",
				"media_id": movieId,
				"favorite": isFavorite
			]
		case .watchlistFlag(_, let movieId, let addWatchlist, _):
			return [
				"media_type": "movie",
				"media_id": movieId,
				"watchlist": addWatchlist
			]
		default:
			return nil
		}
	}
	
	var queryString: [String : Any]? {
		switch self {
		case .createSession(let token):
			return ["request_token":token]
		case .validateWithLogin(let userName, let password, let token):
			return [
				"request_token":token,
				"username" : userName,
				"password": password
			]
		case .search(let page, let query):
			return [
				"page" : page,
				"query" : query
			]
		case .account(let sessionId):
			return [
				"session_id" : sessionId
			]
		case .favorites(let page, _, let sessionId):
			return [
				"page" : page,
				"session_id" : sessionId
			]
		case .watchlist(let page, _, let sessionId):
			return [
				"page" : page,
				"session_id" : sessionId
			]
		case .favoriteFlag(_, _, _, let sessionId):
			return [
				"session_id" : sessionId
			]
		case .watchlistFlag(_, _, _, let sessionId):
			return [
				"session_id" : sessionId
			]
		default:
			return nil
		}
	}
	
	var mock: Data? {
		return nil
	}
}
