//
//  WatchlistBusinessModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 11.04.2021.
//

import Foundation

protocol WatchlistBusinessModelProtocol: BaseBusinessModelProtocol {
	var delegate: WatchlistBusinessModelDelegate? { get set }
	func fetchWatchlist()
	func isItemInWatchlist(id: Int) -> Bool
	func changeWatchlistStatus(id: Int)
}

protocol WatchlistBusinessModelDelegate: BaseBusinessModelDelegate {
	func handleOutput(_ output: WatchlistBusinessModelOutput)
}

enum WatchlistBusinessModelOutput {
	case didGetWatchlist(items: [MovieItem])
}

final class WatchlistBusinessModel: BaseBusinessModel {

	weak var delegate: WatchlistBusinessModelDelegate? {
		get {
			return self.baseDelegate as? WatchlistBusinessModelDelegate
		}
		set {
			self.baseDelegate = newValue
		}
	}
}

// MARK: - WatchlistBusinessModelProtocol methods
extension  WatchlistBusinessModel:  WatchlistBusinessModelProtocol {
	func fetchWatchlist() {
		
	}
	
	func isItemInWatchlist(id: Int) -> Bool {
		return false
	}
	
	func changeWatchlistStatus(id: Int) {
		
	}
	
	
}
