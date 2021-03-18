/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension Int
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------

	///
	/// Returns a seconds conversion of a milliseconds integer value.
	///
	public var msToSeconds: Double
	{
		Double(self) / 1000
	}

	///
	/// Returns a date with the value of self as the Unix timestamp.
	///
	public var toDate: Date
	{
		Date(timeIntervalSince1970: Double(self))
	}


	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------

	///
	/// Initializes a new `Int ` instance with a random value below a given `Int`.
	///
	/// - Parameters:
	///    - randomBelow: The upper bound value to create a random value with.
	///
	public init?(randomBelow upperLimit: Int)
	{
		guard upperLimit > 0 else
		{
			return nil
		}
		self.init(arc4random_uniform(UInt32(upperLimit)))
	}


	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------

	///
	/// Returns a random integer in the given range.
	///
	public static func random<T: SignedInteger>(inRange range: ClosedRange<T> = 1 ... 6) -> T
	{
		let length = Int64((range.upperBound - range.lowerBound + 1))
		let value = Int64(arc4random()) % length + Int64(range.lowerBound)
		return T(value)
	}


	///
	/// Runs the code passed as a closure the specified number of times.
	///
	/// - Parameters:
	///    - closure: The code to be run multiple times.
	///
	public func times(_ closure: () -> Void)
	{
		guard self > 0 else
		{
			return
		}
		for _ in 0 ..< self
		{
			closure()
		}
	}
}


extension Int64
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
			case (1_024 * 1_024 * 1_024) ... Int64.max:  return "\(String(format: "%.2f", gigabyte)) gb"
			default:                                     return "\(self) byte"
		}
	}
}
