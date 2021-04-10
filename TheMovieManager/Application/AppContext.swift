//
//  AppContext.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import Foundation

class AppContext {
	static let main = AppContext()
	
	var requestToken: String?
	var requestTokenExpiration: Date?
}
