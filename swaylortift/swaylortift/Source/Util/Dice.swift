/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


public class Dice
{
	/**
	 * Rolls a set of dice with the specified maximum number.
	 *
	 * @param maxValue The maximum value of a single die.
	 * @param diceCount The amount of dice to roll.
	 * @return The rolled die.
	 */
	public class func roll(maxValue:UInt, diceCount:UInt = 1) -> UInt
	{
		var v:UInt = 0;
		for _ in 0 ..< diceCount
		{
			v += UInt.random(inRange: 1 ... maxValue)
		}
		return v;
	}
}
