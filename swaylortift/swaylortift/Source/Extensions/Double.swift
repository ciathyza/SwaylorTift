/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension Double
{
	///
	/// Rounds the double to decimal places value.
	///
	/// - Parameters:
	/// 	- places: The number of decimal places.
	///
	/// - Returns: the rounded value.
	///
	public func rounded(_ places: Int) -> Double
	{
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
