//
//  FavoritesAndWatchlistBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class FavoritesAndWatchlistBuilder: BaseBuilder {
	static func build(mode: FavoritesAndWatchlistSceneMode, completion: @escaping ((FavoritesAndWatchlistViewController) -> Void)) {
		let presentationModel = FavoritesAndWatchlistPresentationModel(mode: mode)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
