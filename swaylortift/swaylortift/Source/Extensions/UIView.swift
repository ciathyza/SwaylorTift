/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import UIKit


extension UIView
{
	/**
	 * Captures an image of the current screen.
	 */
	public func captureScreen() -> UIImage
	{
		UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
		drawHierarchy(in: bounds, afterScreenUpdates: false)
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}
}
