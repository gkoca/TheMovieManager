//
//  Caller.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation

#if DEBUG
public var IS_CALLER_TESTING: Bool = false
#endif

func isCallerTesting() -> Bool {
	#if DEBUG
	return IS_CALLER_TESTING
	#else
	return false
	#endif
}

private var requestCounter: Int = 0

enum CallerError: Error {
	case emptyMock
}

extension CallerError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .emptyMock:
			return "mock is nil"
		}
	}
}

protocol ParameterEncoder {
	func encode(urlRequest: inout URLRequest, with parameters: [String: Any])
}

struct URLParameterEncoder: ParameterEncoder {
	func encode(urlRequest: inout URLRequest, with parameters: [String: Any]) {
		guard let url = urlRequest.url else { fatalError("Missing URL") }
		if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
			if urlComponents.queryItems == nil {
				urlComponents.queryItems = [URLQueryItem]()
			}
			parameters.forEach {
				let queryItem = URLQueryItem(name: $0, value: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
				urlComponents.queryItems?.append(queryItem)
			}
			urlRequest.url = urlComponents.url
		}
	}
}

struct JSONParameterEncoder: ParameterEncoder {
	func encode(urlRequest: inout URLRequest, with parameters: [String : Any]) {
		if let jsonAsData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) {
			urlRequest.httpBody = jsonAsData
		}
	}
}

public enum ParameterEncoding {
	
	case urlEncoding
	case jsonEncoding
	
	public func encode(urlRequest: inout URLRequest, parameters: [String: Any]?, apiKey: String?) {
		if let apiKey = apiKey {
			let apikeyParam = ["api_key": apiKey]
			URLParameterEncoder().encode(urlRequest: &urlRequest, with: apikeyParam)
		}
		
		switch self {
		case .urlEncoding:
			guard let urlParameters = parameters else { return }
			URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
		case .jsonEncoding:
			guard let bodyParameters = parameters else { return }
			JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
		}
	}
}

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
}

public enum HTTPTask {
	case requestParameters(parameters: [String: Any]?, encoding: ParameterEncoding)
}

protocol Caller {
	var apiKey: String? { get }
	var baseURL: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var parameters: [String: Any] { get }
	var task: HTTPTask { get }
	var mock: Data? { get }
}

extension Caller {
	
	public func call<T: Decodable>(shoudShowLoading: Bool = true, completion: @escaping (T?, Error?) -> Void) {
		call(createRequest(), shoudShowLoading: shoudShowLoading, completion: completion)
	}
	
	private func createRequest() -> URLRequest {
		var request = URLRequest(url: baseURL.appendingPathComponent(path))
		request.httpMethod = method.rawValue
		request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
		
		switch task {
		case .requestParameters(let parameters, let encoding):
			encoding.encode(urlRequest: &request, parameters: parameters, apiKey: apiKey)
		}
		return request
	}
	
	private func call<T: Decodable>(_ urlRequest: URLRequest, shoudShowLoading: Bool,
									completion: @escaping ((T?, Error?) -> Void)) {
		func decode(data: Data) throws -> T? {
			let decoder = JSONDecoder()
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd"
			decoder.dateDecodingStrategy = .formatted(dateFormatter)
			return try decoder.decode(T.self, from: data)
		}
		
		if IS_CALLER_TESTING {
			do {
				guard let data = mock else {
					throw CallerError.emptyMock
				}
				let response = try decode(data: data)
				completion(response, nil)
			} catch {
				completion(nil, error)
			}
		} else {
			if shoudShowLoading {
				Loading.show()
			}
			callData(urlRequest) { (data, error) in
				if shoudShowLoading {
					Loading.hide()
				}
				if let data = data {
					do {
						let response = try decode(data: data)
						completion(response, nil)
					} catch {
						completion(nil, error)
					}
				} else {
					completion(nil, error)
				}
			}
		}
	}
	
	private func callData(_ urlRequest: URLRequest, completion: @escaping ((Data?, Error?) -> Void)) {
		let requesting = requestCounter
		requestCounter += 1
		LOG("<----- REQUESTING \(String(format: "%06d", requesting))----->")
		LOG("URL: \(urlRequest.url?.absoluteString ?? "")")
		printData(urlRequest.httpBody)
		LOG("<-------- REQUESTING -------->")
		
		let task = Session.shared.session
			.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
				DispatchQueue.main.async {
					self.printRequest(urlRequest.url?.absoluteString ?? "", counter: requesting)
					self.printResponse(data, counter: requesting)
					completion(data, error)
				}
			})
		task.resume()
	}
	
	private func printRequest(_ url: String, counter: Int) {
		LOG("<---- REQUESTED \(String(format: "%06d", counter)) --->")
		LOG("Endpoint: \(url)")
		LOG("<------- REQUESTED ------->")
	}
	
	private func printResponse(_ data: Data?, counter: Int) {
		LOG("<----- RESPONSE \(String(format: "%06d", counter)) ---->")
		printData(data)
		LOG("<-------- RESPONSE -------->")
	}
	
	private func printData(_ data: Data?) {
		if let data = data {
			if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
			   let json = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
			   let string = String(data: json, encoding: .utf8) {
				LOG(string)
			} else if let string = String(data: data, encoding: .utf8) {
				LOG(string)
			}
		}
	}
}
