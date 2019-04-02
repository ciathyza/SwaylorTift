/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension DispatchTimeInterval
{
	/// - Returns: The time in seconds using the`TimeInterval` type.
	public var timeInterval:TimeInterval
	{
		switch self
		{
			case .seconds(let seconds): return Double(seconds)
			case .milliseconds(let milliseconds): return Double(milliseconds) / Timespan.millisecondsPerSecond
			case .microseconds(let microseconds): return Double(microseconds) / Timespan.microsecondsPerSecond
			case .nanoseconds(let nanoseconds): return Double(nanoseconds) / Timespan.nanosecondsPerSecond
			case .never: return TimeInterval.infinity
		}
	}
}
