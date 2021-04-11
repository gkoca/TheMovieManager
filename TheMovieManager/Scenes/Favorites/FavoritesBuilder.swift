//
//  FavoritesBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class FavoritesBuilder: BaseBuilder {

	static func build(completion: @escaping ((FavoritesViewController) -> Void)) {
		let presentationModel = FavoritesPresentationModel() 
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
