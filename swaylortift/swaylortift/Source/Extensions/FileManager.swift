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
	/// Returns free disk space as file size.
	///
    @available(*, deprecated, message: "Use UIDevice.current.freeDiskSpaceInBytes instead.")
	public var availableDiskSpace: Filesize
	{
		let freeSizeResult = FileManager.default.systemFreeSizeBytes
		switch freeSizeResult
		{
			case .failure(let error):
				Log.error(category: SWAYLOR_TIFT_NAME, error)
				return Filesize(byte: -1)
			case .success(let filesize):
				return filesize
		}
	}


	///
	/// Returns free disk space in Bytes.
	///
    @available(*, deprecated, message: "Use UIDevice.current.freeDiskSpaceInBytes instead.")
	public var systemFreeSizeBytes: Result<Filesize, Error>
	{
		do
		{
			var attrs: [FileAttributeKey : Any]?
			if #available(macCatalyst 13.0, *)
			{
				attrs = try attributesOfFileSystem(forPath: NSHomeDirectory())
			}
			else
			{
				return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "attributesOfFileSystem API not available on this system."]))
			}

			guard let bytes = attrs?[.systemFreeSize] as? Int64 else
			{
				return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can't retrieve system free size."]))
			}
			return .success(Filesize(byte: bytes))
		}
		catch
		{
			return .failure(error)
		}
	}
}
