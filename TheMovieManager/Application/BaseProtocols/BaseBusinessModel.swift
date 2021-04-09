//
//  BaseBusinessModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation

class BaseBusinessModel: NSObject {
	weak internal var baseDelegate: BaseBusinessModelDelegate?
}

extension BaseBusinessModel: BaseBusinessModelProtocol {
}
