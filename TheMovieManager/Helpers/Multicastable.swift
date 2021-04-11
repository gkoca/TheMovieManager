//
//  Multicastable.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 11.04.2021.
//

import Foundation

protocol Multicastable: class {
	associatedtype Delegate: AnyObject
	
	var delegates: NSHashTable<Delegate> { get set }
	func addDelegate(_ delegate: Delegate)
	func removeDelegate(_ delegate: Delegate)
	func invoke(_ invoker: ((Delegate) -> Void))
}

extension Multicastable {
	func addDelegate(_ delegate: Delegate) {
		if !delegates.contains(delegate) {
			delegates.add(delegate)
		}
	}
	
	func removeDelegate(_ delegate: Delegate) {
		delegates.remove(delegate)
	}
	
	func invoke(_ invoker: ((Delegate) -> Void)) {
		delegates.allObjects.forEach { invoker($0) }
	}
}
