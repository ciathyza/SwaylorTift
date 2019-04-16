/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


public class File
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------

	///
	/// Appends text data to a file. If the file doesn't exist yet, it is created.
	///
	public class func append(filePath:String, content:String, encoding:String.Encoding = .utf16) -> Bool
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
				Log.error(category: SWAYLOR_TIFT_NAME, "Failed to write to \(filePath).")
				return false
			}
		}
		return true
	}
	
	
	///
	/// Deletes the file at the specified file path.
	///
	public class func delete(filePath:String) -> Bool
	{
		do
		{
			try FileManager.default.removeItem(atPath: filePath)
		}
		catch
		{
			Log.error(category: SWAYLOR_TIFT_NAME, "Failed to delete file at \(filePath).")
			return false
		}
		return true
	}
}
