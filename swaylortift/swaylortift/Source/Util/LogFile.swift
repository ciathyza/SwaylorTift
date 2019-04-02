/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


public class LogFile
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public private(set) var filePath = ""
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Creates a new log file with given path.
	 */
	public init(_ filePath:String)
	{
		self.filePath = filePath
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Appends text data to the file. If the file doesn't exist yet, it is created.
	 */
	public func append(content:String, encoding:String.Encoding = .utf16)
	{
		if let fileHandle = FileHandle(forWritingAtPath: filePath)
		{
			fileHandle.seekToEndOfFile()
			if let data = content.data(using: encoding)
			{
				fileHandle.write(data)
				fileHandle.closeFile()
			}
		}
		else
		{
			do
			{
				try content.write(toFile: filePath, atomically: true, encoding: encoding)
			}
			catch
			{
				Log.error("", "Failed to write to \(filePath).")
			}
		}
	}
	
	
	/**
	 * Deletes the file.
	 */
	public func delete()
	{
		do
		{
			try FileManager.default.removeItem(atPath: filePath)
		}
		catch
		{
		}
	}
}