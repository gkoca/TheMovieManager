//
//  DetailBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class DetailBuilder: BaseBuilder {

	static var presentationModel: DetailPresentationModel?

	static func build(completion: @escaping ((DetailViewController) -> Void)) {
		presentationModel = DetailPresentationModel() // init with businessModel(s)
		presentationModel?.loadScene { viewController in
			completion(viewController)
		}
	}
}
