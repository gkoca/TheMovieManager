//
//  LoginViaWebBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class LoginViaWebBuilder: BaseBuilder {

	static var presentationModel: LoginViaWebPresentationModel?

	static func build(completion: @escaping ((LoginViaWebViewController) -> Void)) {
		presentationModel = LoginViaWebPresentationModel() // init with businessModel(s)
		presentationModel?.loadScene { viewController in
			completion(viewController)
		}
	}
}
