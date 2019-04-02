/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension Encodable
{
	public var dictionary:[String:Any]?
	{
		guard let data = try? JSONEncoder().encode(self) else
		{
			return nil
		}
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap
		{
			$0 as? [String:Any]
		}
	}
}
