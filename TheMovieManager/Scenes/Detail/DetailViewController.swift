//
//  DetailViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit

final class DetailViewController: BaseViewController {
	var presentationModel: DetailPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? DetailPresentationModelProtocol
		}
		set {
			self.basePresentationModel = newValue
		}
	}

	// MARK: - ui controls
	@IBOutlet weak var backdropImageView: UIImageView!
	@IBOutlet weak var voteAverageLabel: UILabel!
	@IBOutlet weak var overviewTextView: UITextView!
	@IBOutlet weak var releaseDateLabel: UILabel!
	var favoriteButton: UIBarButtonItem?
	var watchlistButton: UIBarButtonItem?
	// MARK: - members

	// MARK: - initialize
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		let inFavorites = presentationModel?.isItemInFavorites() ?? false
		let inWatchlist = presentationModel?.isItemInWatchlist() ?? false
		let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
		let favImage =  UIImage(systemName: inFavorites ? "star.fill" : "star",
								withConfiguration: lightConfiguration)
		let watchListImage = UIImage(systemName: inWatchlist ? "text.badge.minus" : "text.badge.plus",
									 withConfiguration: lightConfiguration)
		watchlistButton = UIBarButtonItem(image: watchListImage, style: .plain, target: self, action:#selector(watchlistButtonAction(sender:)))
		favoriteButton = UIBarButtonItem(image: favImage, style: .plain, target: self, action: #selector(favoriteButtonAction(sender:)))
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setToolbarHidden(false, animated: false)
		guard let fav = favoriteButton, let wat = watchlistButton else { return }
		self.toolbarItems = [wat, fav]
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setToolbarHidden(true, animated: false)
	}

	// MARK: - custom methods
	func setupView() {
		backdropImageView.load(from: presentationModel?.item.backdrop_path ?? "", placeholder: "placeholderWide")
		title = presentationModel?.item.title
		voteAverageLabel.text = "⭐️ \(presentationModel?.item.vote_average ?? 0)"
		releaseDateLabel.text = "\(presentationModel?.item.release_date ?? "----") 📅"
		overviewTextView.text = presentationModel?.item.overview
	}
	
	@objc func favoriteButtonAction(sender: UIBarButtonItem) {
		presentationModel?.changeFavoriteStatus()
	}
	
	@objc func watchlistButtonAction(sender: UIBarButtonItem) {
		presentationModel?.changeWatchlistStatus()
	}
}

// MARK:- DetailViewControllerProtocol methods
extension DetailViewController: DetailViewControllerProtocol {
	func handleOutput(_ output:  DetailPresentationModelOutput) {
		switch output {
		case .didChangeFavoriteStatus(let isInFavorites):
			let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
			let favImage =  UIImage(systemName: isInFavorites ? "star.fill" : "star",
									withConfiguration: lightConfiguration)
			favoriteButton?.image = favImage
		case .didChangeWatchlistStatus(let isInWatchlist):
			let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
			let watchListImage = UIImage(systemName: isInWatchlist ? "text.badge.minus" : "text.badge.plus",
										 withConfiguration: lightConfiguration)
			watchlistButton?.image = watchListImage
		}
	}
}
