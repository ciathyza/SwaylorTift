/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import UIKit


extension UIApplication
{
	///
	/// The application version found in the main bundle, aka CFBundleShortVersionString.
	///
	public static var appVersion: String
	{
		if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
		{
			return "\(appVersion)"
		}
		return ""
	}

	///
	/// The application build number found in the main bundle, aka kCFBundleVersionKey.
	///
	public static var buildNumber: String
	{
		if let buildNum = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String)
		{
			return "\(buildNum)"
		}
		return ""
	}

	///
	/// Pretty-printed version string of app version + build number, e.g. 1.2.1.733
	///
	public static var versionString: String
	{
		"\(appVersion).\(buildNumber)"
	}
}
