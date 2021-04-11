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
		}
	}
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		if let term = searchController.searchBar.text {
			LOG("\(#function) \(term)")
//			presentationModel?.search(term: term)
		}
	}
}
