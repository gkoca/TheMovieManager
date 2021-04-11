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
		let searchBusinessModel = SearchMovieBusinessModel()
		let presentationModel = SearchPresentationModel(authentication: authentication, search: searchBusinessModel)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
