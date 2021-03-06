/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import UIKit


///
/// RBG Color structure.
///
public struct RGBColor
{
	let R: Int
	let G: Int
	let B: Int
}


///
/// UI Color extensions.
///
extension UIColor
{
	public var rgbColor: RGBColor
	{
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0

		getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		return RGBColor(R: Int(red * 255), G: Int(green * 255), B: Int(blue * 255))
	}


	@objc func colorDescription() -> String
	{
		let color = rgbColor
		return "\(color) - " + ColorLog.background(color, object: " ")
	}


	///
	/// Swizzle description method with own colorDescription. colorDescription will be used instead of description.
	///
	public class func swizzleDescription()
	{
		let instance = UIColor.red
		instance.swizzleMethods(#selector(getter:NSObjectProtocol.description), withSelector: #selector(UIColor.colorDescription))
	}


	///
	/// Restore back original description method.
	///
	public class func undoDesriptionSwizzling()
	{
		let instance = UIColor.red
		instance.swizzleMethods(#selector(UIColor.colorDescription), withSelector: #selector(getter:NSObjectProtocol.description))
	}
}


// ------------------------------------------------------------------------------------------------
extension RGBColor: CustomStringConvertible
{
	public var description: String
	{
		"RGB: \(R), \(G), \(B)"
	}
}


// ------------------------------------------------------------------------------------------------
extension RGBColor: RGBColorType
{
	///
	/// Color representation for XcodeColors console log.
	///
	public var colorCode: String
	{
		"\(R),\(G),\(B)"
	}
}
