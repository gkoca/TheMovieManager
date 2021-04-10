//
//  WatchlistBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class WatchlistBuilder: BaseBuilder {

	static var presentationModel: WatchlistPresentationModel?

	static func build(completion: @escaping ((WatchlistViewController) -> Void)) {
		presentationModel = WatchlistPresentationModel() // init with businessModel(s)
		presentationModel?.loadScene { viewController in
			completion(viewController)
		}
	}
}
