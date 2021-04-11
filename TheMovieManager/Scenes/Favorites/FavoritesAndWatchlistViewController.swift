//
//  FavoritesViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class FavoritesAndWatchlistViewController: BaseViewController {
	var presentationModel: FavoritesAndWatchlistPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? FavoritesAndWatchlistPresentationModelProtocol
		}
		set {
			self.basePresentationModel = newValue
		}
	}

	// MARK: - ui controls
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - initialize
	override func viewDidLoad() {
		super.viewDidLoad()
		let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
		switch presentationModel?.mode {
		case .favorites:
			title = "Favorites"
			tabBarItem.image = UIImage(systemName: "star", withConfiguration: lightConfiguration)
			tabBarItem.selectedImage = UIImage(systemName: "star.fill", withConfiguration: lightConfiguration)
		case .watchlist:
			title = "Watchlist"
			tabBarItem.image = UIImage(systemName: "list.bullet", withConfiguration: lightConfiguration)
		default:
			break
		}
	}
}

// MARK:- FavoritesAndWatchlistViewControllerProtocol methods
extension FavoritesAndWatchlistViewController: FavoritesAndWatchlistViewControllerProtocol {
	func handleOutput(_ output:  FavoritesAndWatchlistPresentationModelOutput) {
		switch output {
		case .shouldReload:
			tableView.reloadData()
		}
	}
}

extension FavoritesAndWatchlistViewController: UITableViewDelegate, UITableViewDataSource {
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
		cell.imageView?.image = UIImage(named: "placeholderPortrait")
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
