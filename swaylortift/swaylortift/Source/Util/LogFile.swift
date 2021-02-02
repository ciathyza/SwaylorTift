/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


///
/// Represents a log file to which log data can be written to.
///
public class LogFile
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------

	public private(set) var filePath = String.Empty


	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------

	///
	/// Creates a new log file with given path.
	///
	public init(_ filePath: String)
	{
		self.filePath = filePath
	}


	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------

	///
	/// Appends text data to the file. If the file doesn't exist yet, it is created.
	///
	public func append(content: String, encoding: String.Encoding = .utf16) -> Bool
	{
		if let fileHandle = FileHandle(forWritingAtPath: filePath)
		{
			if #available(macCatalyst 13.0, *)
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
				// Fallback on earlier versions
				Swift.print("[ERROR] Operation not supported: fileHandle.write", terminator: Log.terminator)

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
				Log.error(category: SWAYLOR_TIFT_NAME, "Failed to write to \(filePath).")
				return false
			}
		}
		return true
	}


	///
	/// Deletes the file.
	///
	public func delete() -> Bool
	{
		do
		{
			if #available(macCatalyst 13.0, *)
			{
				try FileManager.default.removeItem(atPath: filePath)
			}
			else
			{
				// Fallback on earlier versions
				Swift.print("[ERROR] Operation not supported: FileManager.default.removeItem", terminator: Log.terminator)
			}
		}
		catch
		{
			return false
		}
		return true
	}
}
