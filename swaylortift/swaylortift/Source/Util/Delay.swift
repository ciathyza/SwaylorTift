/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


public struct Delay
{
	///
	/// Executes a code block after x seconds on the main dispatch queue.
	///
	public static func executeAfter(_ seconds:Double, _ block:@escaping () -> Void)
	{
		DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: block)
	}
}
