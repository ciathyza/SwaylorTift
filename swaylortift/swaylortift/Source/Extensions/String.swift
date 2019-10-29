/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import Foundation


extension String
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Constants
	// ----------------------------------------------------------------------------------------------------
	
	public static let Empty = ""
	public static let Space = " "
	public static let Period = "."
	public static let Comma = ","
	public static let LF    = "\n"
	public static let Numbers = "0123456789"
	public static let Alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	public static let AlphabetAndNumbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	///
	/// The type of allowed characters.
	///
	/// - Numeric:          Allow all numbers from 0 to 9.
	/// - Alphabetic:       Allow all alphabetic characters ignoring case.
	/// - AlphaNumeric:     Allow both numbers and alphabetic characters ignoring case.
	/// - AllCharactersIn:  Allow all characters appearing within the specified String.
	///
	public enum AllowedCharacters
	{
		case numeric
		case alphabetic
		case alphaNumeric
		case allCharactersIn(String)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------

	///
	/// Convenience accessor for the NSLocalized string.
	///
	public var localized:String
	{
		return NSLocalizedString(self, comment: String.Empty)
	}

	///
	/// Length of the string.
	///
	public var length:Int
	{
		return self.count
	}
	
	///
	/// The string as a NSString.
	///
	public var ns:NSString
	{
		return self as NSString
	}
	
	public var lastPathComponent:String
	{
		return ns.lastPathComponent
	}
	
	public var stringByDeletingPathExtension:String
	{
		return ns.deletingPathExtension
	}
	
	///
	/// Trims whitespace from start and end of string.
	///
	public var trimmed:String
	{
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	///
	/// Strips all whitespace from the string.
	///
	public var stripped:String
	{
		return components(separatedBy: .whitespaces).joined()
	}
	
	///
	/// Checks whether the string can be interpreted as a number.
	///
	public var isNumber:Bool
	{
		return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
	}

	///
	/// Returns false if string contains any characters other than whitespace or newline characters, else true.
	///
	public var isBlank:Bool
	{
		return trimmed.isEmpty
	}
	
	///
	/// Returns a random character from the CharacterView or nil if empty.
	///
	public var sample:Character?
	{
		return isEmpty ? nil : self[index(startIndex, offsetBy: Int(randomBelow: count)!)]
	}
	
	///
	/// Obscures the string with "*" character.
	///
	public var obscured:String
	{
		return String(repeating: "*", count: count)
	}

	///
	/// Converts the string to an Integer.
	///
	public var toInt:Int
	{
		if let n = Int(self)
		{
			return n
		}
		return 0
	}
	
	///
	/// Converts the string to an unsigned Integer.
	///
	public var toUInt:UInt
	{
		if let n = UInt(self)
		{
			return n
		}
		return 0
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	///
	/// Create new instance with random numeric/alphabetic/alphanumeric String of given length.
	///
	/// - Parameters:
	///   - randommWithLength:      The length of the random String to create.
	///   - allowedCharactersType:  The allowed characters type, see enum `AllowedCharacters`.
	///
	public init(randomWithLength length:Int, allowedCharactersType:AllowedCharacters)
	{
		let allowedCharsString:String =
		{
			switch allowedCharactersType
			{
				case .numeric: return String.Numbers
				case .alphabetic: return String.Alphabet
				case .alphaNumeric: return String.AlphabetAndNumbers
				case .allCharactersIn(let allowedCharactersString): return allowedCharactersString
			}
		}()
		
		self.init(allowedCharsString.sample(size: length)!)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	///
	/// Returns a given number of random characters from the `CharacterView`.
	///
	/// - Parameters:
	///    - size: The number of random characters wanted.
	/// - Returns: A `CharacterView` with the given number of random characters or `nil` if empty.
	///
	public func sample(size:Int) -> String?
	{
		if isEmpty { return nil }
		
		var sampleElements = String()
		size.times { sampleElements.append(sample!) }
		
		return sampleElements
	}
	
	
	///
	/// Splits the string into an array where it finds the given separator.
	///
	public func split(_ separator:String) -> [String]
	{
		return self.components(separatedBy: separator)
	}
	
	
	public func substr(from:Int, to:Int) -> String
	{
		if count < 1
		{
			return self
		}
		var fromIndex = from
		var toIndex = to
		
		if fromIndex > toIndex
		{
			let tmp = fromIndex
			fromIndex = toIndex
			toIndex = tmp
		}
		
		fromIndex = fromIndex < 0 ? 0 : fromIndex > count ? count : fromIndex
		toIndex = toIndex > count - 1 ? count - 1 : to < 0 ? 0 : toIndex
		
		let end = (toIndex - self.count) + 1
		let indexStartOfText = self.index(self.startIndex, offsetBy: fromIndex)
		let indexEndOfText = self.index(self.endIndex, offsetBy: end)
		let substring = self[indexStartOfText ..< indexEndOfText]
		return String(substring)
	}
	
	
	public func substr(from:Int) -> String
	{
		return self.substr(from: from, to: self.count - 1)
	}
	
	
	public func substr(to:Int) -> String
	{
		return self.substr(from: 0, to: to)
	}
	

	///
	/// Returns the specified number of characters from the left of the string.
	///
	public func left(_ to:Int) -> String
	{
		var t = to
		if (t > self.count)
		{
			t = self.count
		}
		else if (t < 0)
		{
			t = 0
		}
		return "\(self[..<self.index(startIndex, offsetBy: t)])"
	}
	
	
	///
	/// Returns the specified number of characters from the right of the string.
	///
	public func right(_ from:Int) -> String
	{
		var f = from
		if (f > self.count)
		{
			f = self.count
		}
		else if (f < 0)
		{
			f = 0
		}
		return "\(self[self.index(startIndex, offsetBy: self.count - f)...])"
	}
	
	
	///
	/// Returns the specified number of characters from the given start point of the string.
	///
	public func mid(_ from:Int, _ count:Int = -1) -> String
	{
		var f = from
		if (f < 0)
		{
			f = 0
		}
		let x = "\(self[self.index(startIndex, offsetBy: f)...])"
		return x.left(count == -1 ? x.count : count)
	}
	

	///
	/// Returns the substring that is found after the specified search string.
	///
	public func midAfter(_ search:String, _ count:Int = -1) -> String
	{
		let r = self.range(of: search)
		if (r == nil)
		{
			return ""
		}
		let lb = r!.lowerBound
		let x = "\(self[lb...])".mid(1)
		return x.left(count == -1 ? x.count : count)
	}
	
	
	public func matches(for regex:String) -> [String]
	{
		do
		{
			let regex = try NSRegularExpression(pattern: regex)
			let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
			return results.map
			{
				String(self[Range($0.range, in: self)!])
			}
		}
		catch
		{
			return []
		}
	}
	

	///
	/// Generates a string of random letters and numbers.
	///
	static func random(_ length:Int) -> String
	{
		var s = String.Empty
		for _ in 0 ..< length
		{
			let r = Int(arc4random_uniform(UInt32(String.AlphabetAndNumbers.count)))
			s += String(String.AlphabetAndNumbers[String.AlphabetAndNumbers.index(String.AlphabetAndNumbers.startIndex, offsetBy: r)])
		}
		return s
	}
}


extension StringProtocol where Index == String.Index
{
	public func startIndex<T:StringProtocol>(of string:T, options:String.CompareOptions = []) -> Index?
	{
		return range(of: string, options: options)?.lowerBound
	}
	
	
	public func endIndex<T:StringProtocol>(of string:T, options:String.CompareOptions = []) -> Index?
	{
		return range(of: string, options: options)?.upperBound
	}
	
	
	public func indexes<T:StringProtocol>(of string:T, options:String.CompareOptions = []) -> [Index]
	{
		var result:[Index] = []
		var start = startIndex
		while start < endIndex, let range = range(of: string, options: options, range: start ..< endIndex)
		{
			result.append(range.lowerBound)
			start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
		}
		return result
	}
	
	
	public func ranges<T:StringProtocol>(of string:T, options:String.CompareOptions = []) -> [Range<Index>]
	{
		var result:[Range<Index>] = []
		var start = startIndex
		while start < endIndex, let range = range(of: string, options: options, range: start ..< endIndex)
		{
			result.append(range)
			start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
		}
		return result
	}
}
