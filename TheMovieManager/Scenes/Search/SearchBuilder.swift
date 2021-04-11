//
//  SearchBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class SearchBuilder: BaseBuilder {

	static func build(completion: @escaping ((SearchViewController) -> Void)) {
		let presentationModel = SearchPresentationModel() // init with businessModel(s)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
