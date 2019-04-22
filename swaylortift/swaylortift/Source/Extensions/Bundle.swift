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
	///
	/// The version string of the application bundle, e.g. 1.0.0.
	///
	var versionString:String?
	{
		return infoDictionary?["CFBundleShortVersionString"] as? String
	}
	
	///
	/// A pretty-formatted version string of the application bundle, e.g. 1.0.0.
	///
	var versionStringPretty:String
	{
		return "\(versionString ?? "1.0.0")"
	}

	///
	/// The build number of the application bundle, e.g. 2733.
	///
	var buildNumberString:String?
	{
		return infoDictionary?["CFBundleVersion"] as? String
	}
}
