//
//  LoginViaWebBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class LoginViaWebBuilder: BaseBuilder {
	
	static func build(requestToken: String, url: URL, delegate: LoginViaWebSceneDelegate? = nil,
					  completion: @escaping ((LoginViaWebViewController) -> Void)) {
		let presentationModel = LoginViaWebPresentationModel(requestToken: requestToken, url: url)
		presentationModel.delegate = delegate
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
