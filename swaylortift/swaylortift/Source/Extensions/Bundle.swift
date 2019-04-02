/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension Bundle
{
	var versionString:String?
	{
		return infoDictionary?["CFBundleShortVersionString"] as? String
	}
	
	var versionStringPretty:String
	{
		return "\(versionString ?? "1.0.0")"
	}
	
	var buildNumberString:String?
	{
		return infoDictionary?["CFBundleVersion"] as? String
	}
}
