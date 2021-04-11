//
//  SearchMovieBusinessModel.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 11.04.2021.
//

import Foundation

protocol SearchMovieBusinessModelProtocol: BaseBusinessModelProtocol {
	var delegate: SearchMovieBusinessModelDelegate? { get set }
	func search(page: Int, query: String)
}

protocol SearchMovieBusinessModelDelegate: BaseBusinessModelDelegate {
	func handleOutput(_ output: SearchMovieBusinessModelOutput)
}

enum SearchMovieBusinessModelOutput {
	case didGetSearchResult(page: Int, items: [MovieItem], total: Int)
}

final class SearchMovieBusinessModel: BaseBusinessModel {

	weak var delegate: SearchMovieBusinessModelDelegate? {
		get {
			return self.baseDelegate as? SearchMovieBusinessModelDelegate
		}
		set {
			self.baseDelegate = newValue
		}
	}
}

// MARK: - SearchMovieBusinessModelProtocol methods
extension  SearchMovieBusinessModel:  SearchMovieBusinessModelProtocol {
	func search(page: Int, query: String) {
		API.search(page: page, query: query).call(shoudShowLoading: false) { [weak self] (response: SearchResponse?, error) in
			if let response = response {
				self?.delegate?.handleOutput(.didGetSearchResult(page: response.page,
																 items: response.results,
																 total: response.totalPages))
			}
		}
	}
}
