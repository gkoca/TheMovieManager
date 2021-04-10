//
//  MainBuilder.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

class MainBuilder: BaseBuilder {

	static var presentationModel: MainPresentationModel?

	static func build(completion: @escaping ((MainViewController) -> Void)) {
		presentationModel = MainPresentationModel() // init with businessModel(s)
		presentationModel?.loadScene { viewController in
			completion(viewController)
		}
	}
}
