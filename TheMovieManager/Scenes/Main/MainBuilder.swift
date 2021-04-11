//
//  MainBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class MainBuilder: BaseBuilder {
	static func build(completion: @escaping ((MainViewController) -> Void)) {
		let authentication = AuthenticationBusinessModel()
		let presentationModel = MainPresentationModel(with: authentication)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
