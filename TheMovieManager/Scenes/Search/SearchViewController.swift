//
//  SearchViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class SearchViewController: BaseViewController {
	var presentationModel: SearchPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? SearchPresentationModelProtocol
		}
		set {
			self.basePresentationModel = newValue
		}
	}

	// MARK: - ui controls
	private let searchController = UISearchController(searchResultsController: nil)
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - members

	// MARK: - initialize
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Search"
		let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
		tabBarItem.image = UIImage(systemName: "magnifyingglass", withConfiguration: lightConfiguration)
		setupNavigationBar()
		setupSearchController()
	}

	// MARK: - custom methods
	func setupNavigationBar() {
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonAction))
	}
	
	@objc func logoutButtonAction() {
		presentationModel?.logout()
	}
	
	private func setupSearchController() {
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search by movie name"
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.obscuresBackgroundDuringPresentation = false
		definesPresentationContext = true
	}
}

// MARK:- SearchViewControllerProtocol methods
extension SearchViewController: SearchViewControllerProtocol {
	func handleOutput(_ output:  SearchPresentationModelOutput) {
		switch output {
		case .didGetMovies(let isFresh):
			tableView.reloadData()
			if isFresh {
				let topRow = IndexPath(row: 0,section: 0)
				self.tableView.scrollToRow(at: topRow, at: .top, animated: false)
			}
		}
	}
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presentationModel?.items.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let items = presentationModel?.items,
			let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")
		else { return UITableViewCell() }
		
		let item = items[indexPath.row]
		let title = item.title ?? "no name"
		let year = item.release_date?.prefix(4) ?? "----"
		
		cell.textLabel?.text = "\(title) - \(year)"
		
		if indexPath.row == items.count - 6 {
			presentationModel?.loadMore()
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		if let query = searchController.searchBar.text, query.count > 2 {
			presentationModel?.search(query: query)
		}
	}
}
