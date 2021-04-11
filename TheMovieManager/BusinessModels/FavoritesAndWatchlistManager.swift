//
//  FavoritesAndWatchlistManager.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 11.04.2021.
//

import Foundation

@objc protocol FavoritesAndWatchlistManagerDelegate: class {
	@objc optional func didGetFavorites(items: [MovieItem])
	@objc optional func didChangeFavoriteStatus(item: MovieItem, isFavorite: Bool)
	@objc optional func didChangeWatchlistStatus(item: MovieItem, isInWatchlist: Bool)
	@objc optional func didModifiedFavorites(items: [MovieItem])
	@objc optional func didModifiedWatchlist(items: [MovieItem])
}

final class FavoritesAndWatchlistManager: Multicastable {
	
	var delegates: NSHashTable<FavoritesAndWatchlistManagerDelegate> = NSHashTable<FavoritesAndWatchlistManagerDelegate>.weakObjects()
	static let shared = FavoritesAndWatchlistManager()
	
	var favorites: [MovieItem] = []
	var watchlist: [MovieItem] = []
	
	private var loadingGroup = DispatchGroup()
	
	func load(completion: @escaping (() -> Void)) {
		loadingGroup.enter()
		fetchFavorites()
		loadingGroup.enter()
		fetchWatchlist()
		
		loadingGroup.notify(queue: .main) {
			completion()
		}
	}
	
	private func fetchFavorites() {
		favorites = []
		fetchFavorites(page: 1)
	}
	
	private func fetchFavorites(page: Int) {
		guard let accountId = AppContext.main.accountId, let sessionId = AppContext.main.sessionId else { return }
		API.favorites(page: page, accountId: accountId, sessionId: sessionId).call { (response: MovieListResponse?, error) in
			if let response = response {
				self.favorites.append(contentsOf: response.results)
				if page < response.totalPages {
					self.fetchFavorites(page: page + 1)
				} else {
					self.loadingGroup.leave()
				}
			} else {
				self.loadingGroup.leave()
			}
		}
	}
	
	private func fetchWatchlist() {
		watchlist = []
		fetchWatchlist(page: 1)
	}
	
	private func fetchWatchlist(page: Int) {
		guard let accountId = AppContext.main.accountId, let sessionId = AppContext.main.sessionId else { return }
		API.watchlist(page: page, accountId: accountId, sessionId: sessionId).call { (response: MovieListResponse?, error) in
			if let response = response {
				self.watchlist.append(contentsOf: response.results)
				if page < response.totalPages {
					self.fetchWatchlist(page: page + 1)
				} else {
					self.loadingGroup.leave()
				}
			} else {
				self.loadingGroup.leave()
			}
		}
	}
	
	func isItemInFavoite(id: Int) -> Bool {
		return favorites.contains(where: { $0.id == id })
	}
	
	func isItemInWatchlist(id: Int) -> Bool {
		return watchlist.contains(where: { $0.id == id })
	}
	
	func changeFavoriteStatus(item: MovieItem) {
		guard let id = item.id,
			  let accountId = AppContext.main.accountId,
			  let sessionId = AppContext.main.sessionId
		else { return }
		let isFavorite = isItemInFavoite(id: id)
		
		API.favoriteFlag(
			accountId: accountId,
			movieId: id,
			isFavorite: !isFavorite,
			sessionId: sessionId).call { (response: BaseResponse?, error) in
				if response?.success ?? false {
					if isFavorite {
						self.favorites.removeAll(where: { $0.id == id })
					} else {
						self.favorites.append(item)
					}
					self.invoke { $0.didChangeFavoriteStatus?(item: item, isFavorite: !isFavorite) }
					self.invoke { $0.didModifiedFavorites?(items: self.favorites) }
				}
		}
	}
	
	func changeWatchlistStatus(item: MovieItem) {
		guard let id = item.id,
			  let accountId = AppContext.main.accountId,
			  let sessionId = AppContext.main.sessionId
		else { return }
		let isInWatchlist = isItemInWatchlist(id: id)
		
		API.watchlistFlag(
			accountId: accountId,
			movieId: id,
			addWatchlist: !isInWatchlist,
			sessionId: sessionId).call { (response: BaseResponse?, error) in
				if response?.success ?? false {
					if isInWatchlist {
						self.watchlist.removeAll(where: { $0.id == id })
					} else {
						self.watchlist.append(item)
					}
					self.invoke { $0.didChangeWatchlistStatus?(item: item, isInWatchlist: !isInWatchlist) }
					self.invoke { $0.didModifiedWatchlist?(items: self.watchlist) }
				}
		}
	}
}
