//
//  LoginViaWebBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class LoginViaWebBuilder: BaseBuilder {

	static func build(url: URL, completion: @escaping ((LoginViaWebViewController) -> Void)) {
		let presentationModel = LoginViaWebPresentationModel(with: url)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
