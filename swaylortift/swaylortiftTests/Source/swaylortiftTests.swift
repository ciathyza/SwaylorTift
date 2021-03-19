//
//  SwaylorTiftTests.swift
//  SwaylorTiftTests
//
//  Copyright © 2019 Ciathyza. All rights reserved.
//

import XCTest
@testable import SwaylorTift


class SwaylorTiftTests: XCTestCase
{
	override func setUp()
	{
		Log.mode = .None
		if Log.logFile?.delete() ?? false
		{
			Log.debug("Log file deleted.")
		}
	}


	override func tearDown()
	{
	}


	func testFilesize()
	{
		let filesize = Filesize(megabyte: 1.0)
		Log.delimiter()
		Log.debug(filesize.toString())
		Log.debug("Filesize bytes: \(filesize.byte)")
		Log.debug("Filesize kilobytes: \(filesize.kilobyte)")
		Log.debug("Filesize megabytes: \(filesize.megabyte)")
		Log.debug("Filesize gigabytes: \(filesize.gigabyte)")
		Log.debug("Filesize readable: \(filesize.readableUnit)")

		let actualFilesize = Filesize(byte: filesize.byte - (filesize.byte / 10))
		Log.debug("actualFilesize: \(actualFilesize.readableUnit)")
	}


	func testLogMaxSize()
	{
		let freeDiskSpace = FileManager.default.availableDiskSpace

		Log.logFilePath = "debug.log"
		Log.fileLoggingEnabled = true
		Log.logFileMaxSize = Filesize(kilobyte: 10.0)

		Log.delimiter()
		Log.debug("Log file path: \(Log.logFilePath!)")
		Log.debug("\(freeDiskSpace.readableUnit) free on disk")
		Log.debug("Log file max size: \(Log.logFileMaxSize.readableUnit)")
		Log.debug("FileManager.availableDiskSpace: \(FileManager.default.availableDiskSpace.megabyte) mb")
		Log.debug("Log.fileLoggingMinFreeDiskSpaceRequired: \(Log.fileLoggingMinFreeDiskSpaceRequired.megabyte) mb")

		Log.screenLoggingEnabled = false
		Log.mode = .AllOptions

		var count = 0
		repeat
		{
			let n: UInt = UInt.random(inRange: ClosedRange(uncheckedBounds: (0, 6)))
			switch n
			{
				case 0: Log.trace("Some trace test logging data \(count)")
				case 1: Log.debug("Some debug test logging data \(count)")
				case 2: Log.info("Some info test logging data \(count)")
				case 3: Log.notice("Some notice test logging data \(count)")
				case 4: Log.warning("Some warning test logging data \(count)")
				case 5: Log.error("Some error test logging data \(count)")
				case 6: Log.fatal("Some fatal test logging data \(count)")
				default: break
			}
			count = count + 1
		}
		while Log.fileLoggingEnabled

		Log.mode = .None
		Log.screenLoggingEnabled = true
		Log.debug("Log file size: \(Log.logFile != nil ? Log.logFile!.fileSize.readableUnit : "n/a")")
	}


	func testLoggingDiskFull()
	{
		let freeDiskSpace = FileManager.default.availableDiskSpace
		// Simulate x megabyte before disk is seen as near full
		let logFileAlotted = Filesize(megabyte: 2.0)

		Log.delimiter()
		Log.logFilePath = "debug.log"
		Log.fileLoggingEnabled = true
		Log.fileLoggingMinFreeDiskSpaceRequired = Filesize(byte: freeDiskSpace.byte - logFileAlotted.byte)

		Log.debug("Log file path: \(Log.logFilePath!)")
		Log.debug("\(freeDiskSpace.readableUnit) free on disk")
		Log.debug("Alotted log file size: \(logFileAlotted.readableUnit)")
		Log.debug("FileManager.availableDiskSpace: \(FileManager.default.availableDiskSpace.readableUnit)")
		Log.debug("Log.fileLoggingMinFreeDiskSpaceRequired: \(Log.fileLoggingMinFreeDiskSpaceRequired.readableUnit)")

		Log.screenLoggingEnabled = false
		Log.mode = .AllOptions

		var count = 0
		repeat
		{
			let n: UInt = UInt.random(inRange: ClosedRange(uncheckedBounds: (0, 6)))
			switch n
			{
				case 0: Log.trace("Some trace test logging data \(count)")
				case 1: Log.debug("Some debug test logging data \(count)")
				case 2: Log.info("Some info test logging data \(count)")
				case 3: Log.notice("Some notice test logging data \(count)")
				case 4: Log.warning("Some warning test logging data \(count)")
				case 5: Log.error("Some error test logging data \(count)")
				case 6: Log.fatal("Some fatal test logging data \(count)")
				default: break
			}
			count = count + 1
		}
		while Log.fileLoggingEnabled

		Log.mode = .None
		Log.screenLoggingEnabled = true
		Log.debug("Log file size: \(Log.logFile != nil ? Log.logFile!.fileSize.readableUnit : "n/a")")
	}
}
