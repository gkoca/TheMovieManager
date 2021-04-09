//
//  BasePresentationModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation

class BasePresentationModel: NSObject {
	weak internal var baseViewController: BaseViewControllerProtocol?
	internal var baseRouter: BaseRouterProtocol?
}

extension BasePresentationModel: BaseBusinessModelDelegate {
	func didFailure(errorText: String) {
		self.baseViewController?.didFailure(errorText: errorText)
	}
}

