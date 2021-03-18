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
		let filesize = Filesize(gigabyte: 1.0)
		Log.delimiter()
		Log.debug(filesize.toString())
		Log.debug("Filesize bytes: \(filesize.byte)")
		Log.debug("Filesize kilobytes: \(filesize.kilobyte)")
		Log.debug("Filesize megabytes: \(filesize.megabyte)")
		Log.debug("Filesize gigabytes: \(filesize.gigabyte)")
		Log.debug("Filesize readable: \(filesize.readableUnit)")

		assert(filesize.byte == 1073741824)
		assert(filesize.kilobyte == 1048576)
		assert(filesize.megabyte == 1024)
		assert(filesize.gigabyte == 1)
	}


	func testLogging()
	{
		Log.mode = .AllOptions
		Log.fileLoggingEnabled = false
		Log.delimiter()
		Log.trace("Tracing...")
		Log.debug("Debugging...")
		Log.info("Info...")
		Log.notice("Notice...")
		Log.warning("Warning...")
		Log.error("Error...")
		Log.fatal("Fatal...")
	}


	func testLogMaxSize()
	{
		let freeDiskSpace = FileManager.default.availableDiskSpace

		Log.logFilePath = "debug.log"
		Log.mode = .AllOptions
		Log.fileLoggingEnabled = true
		Log.logFileMaxSize = Filesize(kilobyte: 5.0)
		Log.disableLogOnFileLogFull = true

		Log.delimiter()
		Log.debug("Log file path: \(Log.logFilePath!)")
		Log.debug("\(freeDiskSpace.readableUnit) free on disk")
		Log.debug("Log file max size: \(Log.logFileMaxSize.readableUnit)")
		Log.debug("FileManager.availableDiskSpace: \(FileManager.default.availableDiskSpace.megabyte) mb")
		Log.debug("Log.fileLoggingMinFreeDiskSpaceRequired: \(Log.fileLoggingMinFreeDiskSpaceRequired.megabyte) mb")

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
		Log.debug("Log file size: \(Log.logFile != nil ? Log.logFile!.fileSize.readableUnit : "n/a")")
	}


	func testLoggingDiskFull()
	{
		let freeDiskSpace = FileManager.default.availableDiskSpace
		// Write one mb log file befoore disk is seen as near full
		let logFileAlotted = Filesize(megabyte: 1.0)

		Log.logFilePath = "debug.log"
		Log.mode = .AllOptions
		Log.fileLoggingEnabled = true
		Log.fileLoggingMinFreeDiskSpaceRequired = Filesize(byte: freeDiskSpace.byte - logFileAlotted.byte)

		Log.delimiter()
		Log.debug("Log file path: \(Log.logFilePath!)")
		Log.debug("\(freeDiskSpace.readableUnit) free on disk")
		Log.debug("Alotted log file size: \(logFileAlotted.readableUnit)")
		Log.debug("FileManager.availableDiskSpace: \(FileManager.default.availableDiskSpace.megabyte) mb")
		Log.debug("Log.fileLoggingMinFreeDiskSpaceRequired: \(Log.fileLoggingMinFreeDiskSpaceRequired.megabyte) mb")

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
		Log.debug("Log file size: \(Log.logFile != nil ? Log.logFile!.fileSize.readableUnit : "n/a")")
	}


//	func testLoggingLargeFile()
//	{
//		// Run this test only by itself!
//
//		let freeDiskSpace = FileManager.default.availableDiskSpace
//
//		Log.logFilePath = "debug.log"
//		Log.mode = .AllOptions
//		Log.fileLoggingEnabled = true
//		Log.logFileMaxSize = Filesize(megabyte: 100.0)
//		Log.disableLogOnFileLogFull = true
//
//		Log.delimiter()
//		Log.debug("Log file path: \(Log.logFilePath!)")
//		Log.debug("\(freeDiskSpace.readableUnit) free on disk")
//		Log.debug("Log file max size: \(Log.logFileMaxSize.readableUnit)")
//		Log.debug("FileManager.availableDiskSpace: \(FileManager.default.availableDiskSpace.megabyte) mb")
//		Log.debug("Log.fileLoggingMinFreeDiskSpaceRequired: \(Log.fileLoggingMinFreeDiskSpaceRequired.megabyte) mb")
//
//		Log.screenLoggingEnabled = false
//
//		var count = 0
//		repeat
//		{
//			let n: UInt = UInt.random(inRange: ClosedRange(uncheckedBounds: (0, 6)))
//			switch n
//			{
//				case 0: Log.trace("Some trace test logging data \(count)")
//				case 1: Log.debug("Some debug test logging data \(count)")
//				case 2: Log.info("Some info test logging data \(count)")
//				case 3: Log.notice("Some notice test logging data \(count)")
//				case 4: Log.warning("Some warning test logging data \(count)")
//				case 5: Log.error("Some error test logging data \(count)")
//				case 6: Log.fatal("Some fatal test logging data \(count)")
//				default: break
//			}
//			count = count + 1
//		}
//		while Log.fileLoggingEnabled
//
//		Log.screenLoggingEnabled = true
//		Log.debug("Log file size: \(Log.logFile != nil ? Log.logFile!.fileSize.readableUnit : "n/a")")
//	}
}
