/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) Ciathyza
 */

import Foundation


///
/// A boolean flag that can only be set once, until it is reset.
///
public class SetOnceFlag
{
	private var _value = -1

	public var value: Bool
	{
		get
		{
			_value > 0 ? true : false
		}
		set
		{
			if (_value > -1)
			{
				return
			}
			_value = newValue ? 1 : 0
		}
	}


	///
	/// Resets the flag to its initial value (false).
	///
	public func reset()
	{
		_value = -1
	}
}
