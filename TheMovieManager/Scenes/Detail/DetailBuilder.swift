//
//  DetailBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class DetailBuilder: BaseBuilder {
	static func build(item: MovieItem, completion: @escaping ((DetailViewController) -> Void)) {
		let watchlistBusinessModel = WatchlistBusinessModel()
		let presentationModel = DetailPresentationModel(item: item,
														watchlistBusinessModel: watchlistBusinessModel)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
