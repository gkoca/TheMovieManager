//
//  main.swift
//  TheMovieManager
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestAppDelegate") ?? AppDelegate.self

UIApplicationMain(
	CommandLine.argc,
	CommandLine.unsafeArgv,
	nil,
	NSStringFromClass(appDelegateClass))
