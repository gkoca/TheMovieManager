//
//  LoginBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

class LoginBuilder: BaseBuilder {

	static func build(completion: @escaping ((LoginViewController) -> Void)) {
		let authentication = AuthenticationBusinessModel()
		let presentationModel = LoginPresentationModel(with: authentication)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
