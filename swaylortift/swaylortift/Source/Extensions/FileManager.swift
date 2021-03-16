/*    ____                 __           _______ _____
*   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
*  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
* /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
*                 /___/
* Utils & Extensions for Swift Projects
* (c) 2018 Ciathyza
*/

import Foundation

extension FileManager
{
	///
	/// Returns free disk space in MB.
	///
	public func availableDiskSpaceInMB() -> Int64
	{
		let freeSizeResult = FileManager.default.systemFreeSizeBytes()
		switch freeSizeResult
		{
		case .failure(let error):
			Log.error(category: SWAYLOR_TIFT_NAME, error)
			return 0
		case .success(let freeSize):
			let freeSpaceInMB = freeSize / (1024*1024)
			return freeSpaceInMB
		}
	}

	///
	/// Returns free disk space in Bytes.
	///
	public func systemFreeSizeBytes() -> Result<Int64, Error>
	{
		do
		{
			let attrs = try attributesOfFileSystem(forPath: NSHomeDirectory())
			guard let freeSize = attrs[.systemFreeSize] as? Int64 else
			{
				return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Can't retrieve system free size"]))
			}
			return .success(freeSize)
		}
		catch
		{
			return .failure(error)
		}
	}
}
