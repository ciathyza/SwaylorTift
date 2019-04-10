//
// Assert.swift
// swaylortift
//
// Created by Balkau, Sascha on 2019-04-10.
// Copyright (c) 2019 Ciathyza. All rights reserved.
//

import Foundation


///
/// Provides utility methods that can be used during development.
///
public struct Assert
{
	///
	/// Asserts a specific code position as being To do. Fails the app with fatal error.
	///
	public static func TODO() -> Never
	{
		fatalError("TODO")
	}
	
	
	///
	/// Asserts a specific code position as fatal error. Fails the app with fatal error.
	///
	public static func fatal() -> Never
	{
		fatalError("Fatal error")
	}
}
