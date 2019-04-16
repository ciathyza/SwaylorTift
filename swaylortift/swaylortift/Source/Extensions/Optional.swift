/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension Optional where Wrapped:Collection
{
	///
	/// Determines whether an optional collection is nil or empty (true), or not (false).
	///
	var isNilOrEmpty:Bool
	{
		switch self
		{
			case let collection?:
				return collection.isEmpty
			case nil:
				return true
		}
	}
}
