/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import UIKit


extension UIDevice
{
	///
	/// Checks whether the app is currently running on simulator or not.
	///
	public static var isSimulator: Bool
	{
		ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
	}
}


extension UIDevice
{
	public var totalDiskSpaceInGB: String
	{
		ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
	}

	public var freeDiskSpaceInGB: String
	{
		ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
	}

	public var usedDiskSpaceInGB: String
	{
		ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
	}

	public var totalDiskSpaceInMB: String
	{
		MBFormatter(totalDiskSpaceInBytes)
	}

	public var freeDiskSpaceInMB: String
	{
		MBFormatter(freeDiskSpaceInBytes)
	}

	public var usedDiskSpaceInMB: String
	{
		MBFormatter(usedDiskSpaceInBytes)
	}

	public var totalDiskSpaceInBytes: Int64
	{
		guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String), let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else
		{
			return 0
		}
		return space
	}

	/*
	 Total available capacity in bytes for "Important" resources, including space expected to be cleared by purging non-essential and cached resources. "Important" means something that the user or application clearly expects to be present on the local system, but is ultimately replaceable. This would include items that the user has explicitly requested via the UI, and resources that an application requires in order to provide functionality.
	 Examples: A video that the user has explicitly requested to watch but has not yet finished watching or an audio file that the user has requested to download.
	 This value should not be used in determining if there is room for an irreplaceable resource. In the case of irreplaceable resources, always attempt to save the resource regardless of available capacity and handle failure as gracefully as possible.
	 */
	public var freeDiskSpaceInBytes: Int64
	{
		if #available(iOS 11.0, *)
		{
			if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage
			{
				return space
			}
			else
			{
				return 0
			}
		}
		else
		{
			if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String), let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
			{
				return freeSpace
			}
			else
			{
				return 0
			}
		}
	}

	public var usedDiskSpaceInBytes: Int64
	{
		totalDiskSpaceInBytes - freeDiskSpaceInBytes
	}


	public func MBFormatter(_ bytes: Int64) -> String
	{
		let formatter = ByteCountFormatter()
		formatter.allowedUnits = ByteCountFormatter.Units.useMB
		formatter.countStyle = ByteCountFormatter.CountStyle.decimal
		formatter.includesUnit = false
		return formatter.string(fromByteCount: bytes) as String
	}
}
