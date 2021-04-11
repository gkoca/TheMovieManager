//
//  WatchlistBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class WatchlistBuilder: BaseBuilder {

	static func build(completion: @escaping ((WatchlistViewController) -> Void)) {
		let presentationModel = WatchlistPresentationModel() // init with businessModel(s)
		presentationModel.loadScene { viewController in
			completion(viewController)
		}
	}
}
