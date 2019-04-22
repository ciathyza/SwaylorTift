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
/// Stopwatch used to measure duration of code execution.
///
public class StopWatch
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var milliseconds:TimeInterval { return seconds * 1000 }
	public private(set) var seconds:TimeInterval = 0
	public var minutes:TimeInterval { return seconds / 60 }
	
	private weak var timer:Timer?
	private var startTime:TimeInterval = 0
	private var started:Bool
	{
		return timer != nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	///
	/// Starts the stopwatch.
	///
	public func start()
	{
		if started { return }
		
		startTime = Date().timeIntervalSinceReferenceDate
		timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true)
		{
			timer in
			self.seconds = Date().timeIntervalSinceReferenceDate - self.startTime
			DispatchQueue.main.async
			{
			}
		}
	}
	
	
	///
	/// Stops the stopwatch.
	///
	public func stop()
	{
		if !started { return }
		timer!.invalidate()
		timer = nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Class Methods
	// ----------------------------------------------------------------------------------------------------
	
	///
	/// The measured duration as (HH, MM, SS).
	///
	public class func secondsToHoursMinutesSeconds(seconds:Int) -> (Int, Int, Int)
	{
		return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
	}
	
	
	///
	/// The measured duration as (HH, MM, SS).
	///
	public class func secondsToHoursMinutesSeconds(seconds:Double) -> (Int, Int, Int)
	{
		let (hr, minf) = modf(seconds / 3600)
		let (min, secf) = modf(60 * minf)
		return (Int(hr), Int(min), Int(60 * secf))
	}
	
	
	///
	/// The measured duration in milliseconds.
	///
	public class func secondsToMilliseconds(seconds:Double) -> UInt
	{
		return UInt(seconds * 1000)
	}
}
