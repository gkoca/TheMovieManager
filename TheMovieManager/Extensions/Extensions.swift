//
//  Extensions.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

extension UIStoryboard {
	func instantiateViewController<T: UIViewController>(withIdentifier identifier: String? = nil) -> T {
		let identifier = identifier ?? String(describing: T.self)
		return instantiateViewController(withIdentifier: identifier) as! T
	}
}
