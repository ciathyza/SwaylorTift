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
public class Interval
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------

	private var _timer: Timer?
	private var _counter = 0


	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------

	///
	/// Calls a closure at a specified interval.
	///
	/// - Parameters:
	/// 	- interval: The interval in seconds.
	/// 	- repeats: How often the interval should be fired. If 0 repeats infinitely.
	/// 	- callback: Closure to be called at every interval.
	///
	/// - Returns: nil.
	///
	public func start(interval: TimeInterval = 1.0, repeats: Int = 0, callback: (() -> Void)? = nil)
	{
		_counter = 0
		_timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true)
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
				self._counter += 1
				if (self._counter < repeats)
				{
					return
				}
				self.stop()
		}
	}


	///
	/// Fires the interval once.
	///
	public func fire()
	{
		_timer?.fire()
	}


	///
	/// Stops the interval.
	///
	public func stop()
	{
		_timer?.invalidate()
		_timer = nil
	}
}
