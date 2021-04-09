//
//  TestRootViewController.swift
//  TheMovieManagerTests
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

final class TestRootViewController: UIViewController {
	override func loadView() {
		let label = UILabel()
		label.text = "Running Unit Tests..."
		label.textAlignment = .center
		label.textColor = .white
		view = label
	}
}
