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

extension Bundle {
	func infoForKey(_ key: String) -> String? {
		return (infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
	}
}

extension URL {
	init(forceString string: String) {
		guard let url = URL(string: string) else { fatalError("Could not init URL '\(string)'") }
		self = url
	}
}

extension UIView {
	@IBInspectable var cornerRadius: CGFloat {
		set {
			layer.cornerRadius = newValue
		}
		get {
			return layer.cornerRadius
		}
	}
}

extension UIImageView {
	func load(from path: String, contentMode: UIView.ContentMode = .scaleAspectFit, placeholder: String? = nil) {
		self.contentMode = contentMode
		if path.isEmpty {
			LOG("IMAGE -> Path is empty")
			if let placeholder = placeholder {
				LOG("IMAGE -> Returning placeholder")
				self.image = UIImage(named: placeholder)
				return
			}
			LOG(level: .error, "IMAGE -> Returning nil")
			return
		}
		if let image = ImageRepository.shared.getImage(with: path) {
			self.image = image
			return
		}

		let baseImageURLString = Bundle.main.infoForKey("BASE_IMAGE_URL") ?? ""
		let url = URL(forceString: baseImageURLString).appendingPathComponent(path)
		LOG("IMAGE -> downloading from \(url.absoluteString)")
		Session.shared.session.dataTask(with: url) {(data, response, error) in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
			else {
				if let placeholder = placeholder {
					DispatchQueue.main.async { [weak self] in
						LOG("IMAGE -> download failed. Returning placeholder")
						self?.image = UIImage(named: placeholder)
					}
				}
				return
			}
			LOG(level: .info, "IMAGE -> download success. size: \(data.count)")
			ImageRepository.shared.cache(image: image, with: path)
			DispatchQueue.main.async { [weak self] in
				self?.image = image
			}
		}.resume()
	}
}
