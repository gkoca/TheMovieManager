//
//  FavoritesViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class FavoritesViewController: BaseViewController {
	var presentationModel: FavoritesPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? FavoritesPresentationModelProtocol
		}
		set {
			self.basePresentationModel = newValue
		}
	}

	// MARK: - ui controls
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - members

	// MARK: - initialize
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Favorites"
		let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
		tabBarItem.image = UIImage(systemName: "star", withConfiguration: lightConfiguration)
		tabBarItem.selectedImage = UIImage(systemName: "star.fill", withConfiguration: lightConfiguration)
	}

	// MARK: - custom methods
}

// MARK:- FavoritesViewControllerProtocol methods
extension FavoritesViewController: FavoritesViewControllerProtocol {
	func handleOutput(_ output:  FavoritesPresentationModelOutput) {
		switch output {
		}
	}
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presentationModel?.items.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let items = presentationModel?.items,
			let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell")
		else { return UITableViewCell() }
		
		let item = items[indexPath.row]
		cell.textLabel?.text = item.title
		cell.imageView?.load(from: item.poster_path ?? "", placeholder: "placeholderPortrait")
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		64
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presentationModel?.didSelectItem(at: indexPath.row)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
