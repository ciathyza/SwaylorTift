/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension NSObject
{
	public class func swizzleMethods(_ origSelector:Selector, withSelector:Selector, forClass:AnyClass)
	{
		let originalMethod = class_getInstanceMethod(forClass, origSelector)
		let swizzledMethod = class_getInstanceMethod(forClass, withSelector)
		
		method_exchangeImplementations(originalMethod!, swizzledMethod!)
	}
	
	
	public func swizzleMethods(_ origSelector:Selector, withSelector:Selector)
	{
		let aClass:AnyClass! = object_getClass(self)
		NSObject.swizzleMethods(origSelector, withSelector: withSelector, forClass: aClass)
	}
	
	
	///
	/// Creates a new object of self with its concrete type maintained.
	///
	public func createNew() -> Self
	{
		return type(of: self).init()
	}
	
	
	///
	/// Dumps a property-value list of the object.
	///
	public func dumpObj() -> String
	{
		var result = "[\(String(describing: type(of: self))) "
		let mirror = Mirror(reflecting: self)
		mirror.children.forEach
		{
			child in
				result += "\n\t> \(child.label!)=\(child.value)"
		}
		return "\(result)]"
	}
	
	
	///
	/// Dumps a formatted property-value table of the object.
	///
	public class func dump(_ obj:Any) -> String
	{
		let table = TabularText(2, true, String.Space, String.Space, String.Empty, 120, ["Property", "Value"])
		let mirror = Mirror(reflecting: obj)
		mirror.children.forEach
		{
			child in
				if let label = child.label
				{
					table.add([label, "\(child.value)"])
				}
		}
		return table.toString()
	}
	
	
	public func dumpTable() -> String
	{
		return NSObject.dump(self)
	}
}
