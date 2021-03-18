//
//  SwaylorTiftTests.swift
//  SwaylorTiftTests
//
//  Created by Balkau, Sascha on 2019/08/06.
//  Copyright © 2019 Ciathyza. All rights reserved.
//

import XCTest
@testable import SwaylorTift


class SwaylorTiftTests: XCTestCase
{
	override func setUp()
	{
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}


	override func tearDown()
	{
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}


	func testExample()
	{
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
		Log.trace("Tracing...")
		Log.debug("Debugging...")
		Log.info("Info...")
		Log.notice("Notice...")
		Log.warning("Warning...")
		Log.error("Error...")
		Log.fatal("Fatal...")
		Log.trace("\(FileManager.default.availableDiskSpaceInMB()) MB free on disk")
	}


	func testPerformanceExample()
	{
		// This is an example of a performance test case.
		self.measure
		{
			// Put the code you want to measure the time of here.
		}
	}
}
