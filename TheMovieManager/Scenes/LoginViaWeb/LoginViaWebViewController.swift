//
//  LoginViaWebViewController.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 10.04.2021.
//

import UIKit
import WebKit

final class LoginViaWebViewController: BaseViewController {
	var presentationModel: LoginViaWebPresentationModelProtocol? {
		get {
			return self.basePresentationModel as? LoginViaWebPresentationModelProtocol
		}
		set {
			self.basePresentationModel = newValue
		}
	}

	// MARK: - ui controls
	@IBOutlet weak var webView: WKWebView!
	
	// MARK: - members

	// MARK: - initialize
	override func viewDidLoad() {
		super.viewDidLoad()
		webView.navigationDelegate = self
		if let url = presentationModel?.authenticationURL {
			let request = URLRequest(url: url)
			webView.load(request)
		}
	}

	// MARK: - custom methods
}

// MARK:- LoginViaWebViewControllerProtocol methods
extension LoginViaWebViewController: LoginViaWebViewControllerProtocol {
	func handleOutput(_ output:  LoginViaWebPresentationModelOutput) {
		switch output {
		}
	}
}

extension LoginViaWebViewController: WKNavigationDelegate {
	func webView(_ webView: WKWebView,
				 decidePolicyFor navigationAction: WKNavigationAction,
				 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		decisionHandler(.allow)
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		if let url = webView.url {
			LOG("url \(url)")
		}
	}
}
