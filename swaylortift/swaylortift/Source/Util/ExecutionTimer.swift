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
/// A util class that can be used to measure time duration precisely.
///
public class ExecutionTimer
{
	// ------------------------------------------------------------------------------------------------
	// Properties
	// ------------------------------------------------------------------------------------------------

	public private(set) var duration: TimeInterval = 0.0
	private var _date = Date()


	// ------------------------------------------------------------------------------------------------
	// Derived Properties
	// ------------------------------------------------------------------------------------------------

	public var milliseconds: Int
	{
		Int((duration * 1000).truncatingRemainder(dividingBy: 1000))
	}

	public var seconds: Int
	{
		Int((duration).truncatingRemainder(dividingBy: 60))
	}

	var minutes: Int
	{
		Int((duration / 60).truncatingRemainder(dividingBy: 60))
	}

	var hours: Int
	{
		Int((duration / 3600).truncatingRemainder(dividingBy: 60))
	}

	var days: Int
	{
		Int((duration / 86400).truncatingRemainder(dividingBy: 60))
	}

	var time: String
	{
		"\(days)d \(hours)h \(minutes)m \(seconds)s \(milliseconds)ms"
	}

	var timeShort: String
	{
		if days > 0
		{
			return "\(days)d \(hours)h \(minutes)m \(seconds)s"
		}
		else if hours > 0
		{
			return "\(hours)h \(minutes)m \(seconds)s"
		}
		else if minutes > 0
		{
			return "\(minutes)m \(seconds)s"
		}
		return "\(seconds)s"
	}

	var timeLong: String
	{
		if days > 0
		{
			return "\(days) days, \(hours) hours, \(minutes) minutes, and \(seconds) seconds"
		}
		else if hours > 0
		{
			return "\(hours) hours, \(minutes) minutes, and \(seconds) seconds"
		}
		else if minutes > 0
		{
			return "\(minutes) minutes and \(seconds) seconds"
		}
		return "\(seconds) seconds"
	}


	// ------------------------------------------------------------------------------------------------
	// Methods
	// ------------------------------------------------------------------------------------------------

	public func start()
	{
		_date = Date()
	}


	public func stop()
	{
		duration = _date.timeIntervalSinceNow * -1
	}
}
