//
//  SearchBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class SearchBuilder: BaseBuilder {
	static func build(completion: @escaping ((SearchViewController) -> Void)) {
		let authentication = AuthenticationBusinessModel()
		let presentationModel = SearchPresentationModel(with: authentication)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
