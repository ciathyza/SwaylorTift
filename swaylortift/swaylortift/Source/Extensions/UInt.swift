/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension UInt
{
	///
	/// Returns a random unsigned integer in the given range.
	///
	public static func random<T: UnsignedInteger>(inRange range: ClosedRange<T> = 1 ... 6) -> T
	{
		let length = UInt64((range.upperBound - range.lowerBound + 1))
		let value = UInt64(arc4random()) % length + UInt64(range.lowerBound)
		return T(value)
	}
}


extension UInt64
{
	public var kilobyte: Double { Double(self) / 1_024 }
	public var megabyte: Double { kilobyte / 1_024 }
	public var gigabyte: Double { megabyte / 1_024 }

	public var readableUnit: String
	{
		switch self
		{
			case 0 ..< 1_024:                            return "\(self) byte"
			case 1_024 ..< (1_024 * 1_024):              return "\(String(format: "%.2f", kilobyte)) kb"
			case 1_024 ..< (1_024 * 1_024 * 1_024):      return "\(String(format: "%.2f", megabyte)) mb"
			case (1_024 * 1_024 * 1_024) ... UInt64.max: return "\(String(format: "%.2f", gigabyte)) gb"
			default:                                     return "\(self) byte"
		}
	}
}
