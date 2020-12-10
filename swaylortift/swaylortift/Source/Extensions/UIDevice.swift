/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import UIKit


extension UIDevice
{
	///
	/// Checks whether the app is currently running on simulator or not.
	///
	public static var isSimulator: Bool
	{
		ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
	}
}
