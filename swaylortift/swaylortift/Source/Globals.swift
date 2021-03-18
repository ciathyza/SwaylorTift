/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) Ciathyza
 */

import Foundation


// ----------------------------------------------------------------------------------------------------
// MARK: - Global constants
// ----------------------------------------------------------------------------------------------------

public let SWAYLOR_TIFT_NAME    = "Swaylor Tift"
public let SWAYLOR_TIFT_VERSION = "1.0.17"


// ----------------------------------------------------------------------------------------------------
// MARK: - Global functions
// ----------------------------------------------------------------------------------------------------

///
/// Runs code with delay given in seconds. Uses the main thread if not otherwise specified.
///
/// - Parameters:
///   - delayTime: The duration of the delay. E.g. `.seconds(1)` or `.milliseconds(200)`.
///   - qosClass: The global QOS class to be used or `nil` to use the main thread. Defaults to `nil`.
///   - closure: The code to run with a delay.
///
public func delay(by delayTime: Timespan, qosClass: DispatchQoS.QoSClass? = nil, _ closure: @escaping () -> Void)
{
	let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : DispatchQueue.main
	dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: closure)
}
