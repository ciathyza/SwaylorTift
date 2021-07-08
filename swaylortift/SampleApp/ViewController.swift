//
//  ViewController.swift
//  SampleApp
//
//  Created by KM, Abhilash a on 19/03/21.
//  Copyright © 2021 Ciathyza. All rights reserved.
//

import UIKit
import SwaylorTift


class ViewController: UIViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setDebugLogging()
	}


	func setDebugLogging()
	{
		let currentLogfile = "current-launch.txt"
		let oldLogfile = "old-launch.txt"
		var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
		let url = NSURL(fileURLWithPath: documentsPath)
		if let pathComponent = url.appendingPathComponent(currentLogfile)
		{
			let filePath = pathComponent.path
			let fileManager = FileManager.default
			if fileManager.fileExists(atPath: filePath)
			{
				let destinationPath = url.appendingPathComponent(oldLogfile)!
				do
				{
					if fileManager.fileExists(atPath: destinationPath.path)
					{
						try fileManager.removeItem(at: destinationPath)
					}
					try fileManager.moveItem(at: pathComponent, to: destinationPath)
				}
				catch let error as NSError
				{
					Log.debug("Should never come here \(error.description)")
				}
			}
		}

		documentsPath.append("/\(currentLogfile)")
		FileManager.default.createFile(atPath: documentsPath, contents: nil, attributes: nil)
		Log.logFilePath = documentsPath

		Log.enabled = true
		Log.fileLoggingEnabled = true
		Log.fileLoggingMinFreeDiskSpaceRequired = Filesize(megabyte: 8000)
		Log.logFileMaxSize = Filesize(megabyte: 100)

		Log.mode = [.FileName, .FuncName, .Line, .Date]
		Log.debug("Doc Dir Logfile Path ...\(documentsPath)")
		Log.debug("Locale: \(String(describing: Locale.current.languageCode))")
		Log.debug("Available disk space: \(UIDevice.current.freeDiskSpaceInGB)")
		Log.debug("FileLoggingMinFreeDiskSpaceRequired: \(Log.fileLoggingMinFreeDiskSpaceRequired.megabyte) MB")
	}
}
