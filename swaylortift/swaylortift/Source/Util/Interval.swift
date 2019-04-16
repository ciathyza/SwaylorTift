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
/// Used to invoke code blocks at certain intervals.
///
class Interval
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	internal var timer:Timer?
	internal var counter = 0
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/// Calls a closure at a specified interval.
	///
	/// - Parameters:
	/// 	- interval: The interval in seconds.
	/// 	- repeats: How often the interval should be fired. If 0 repeats infinitely.
	/// 	- callback: Closure to be called at every interval.
	///
	/// - Returns: nil.
	public func start(interval:TimeInterval = 1.0, repeats:Int = 0, callback:(() -> Void)? = nil)
	{
		counter = 0
		timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true)
		{
			t in
				if let closure = callback
				{
					closure()
				}
				if repeats < 1
				{
					return
				}
				self.counter += 1
				if (self.counter < repeats)
				{
					return
				}
				self.stop()
		}
	}
	
	
	public func fire()
	{
		timer?.fire()
	}
	
	
	public func stop()
	{
		timer?.invalidate()
		timer = nil
	}
}
