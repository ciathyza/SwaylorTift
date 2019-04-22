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
	///
	/// Captures an image of the current screen.
	///
	public func captureScreen() -> UIImage
	{
		UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
		drawHierarchy(in: bounds, afterScreenUpdates: false)
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}
	
	
	///
	/// Provides a reference to the view's parent view controller.
	///
	public var parentViewController:UIViewController?
	{
		var parentResponder:UIResponder? = self
		while parentResponder != nil
		{
			parentResponder = parentResponder!.next
			if let viewController = parentResponder as? UIViewController
			{
				return viewController
			}
		}
		return nil
	}
	
	
	///
	/// Removes all sub views from the view.
	///
	public func removeAllSubViews()
	{
		self.subviews.forEach({ $0.removeFromSuperview() })
	}
}
