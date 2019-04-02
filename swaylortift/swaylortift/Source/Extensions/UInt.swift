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
	public static func random<T: UnsignedInteger>(inRange range:ClosedRange<T> = 1...6) -> T
	{
		let length = UInt64((range.upperBound - range.lowerBound + 1))
		let value = UInt64(arc4random()) % length + UInt64(range.lowerBound)
		return T(value)
	}
}
