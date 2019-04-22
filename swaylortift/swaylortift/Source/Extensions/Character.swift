/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension Character
{
	///
	/// The scalar unicode code point of the character.
	///
	func unicodeScalarCodePoint() -> UInt32
	{
		let characterString = String(self)
		let scalars = characterString.unicodeScalars
		return scalars[scalars.startIndex].value
	}
}
