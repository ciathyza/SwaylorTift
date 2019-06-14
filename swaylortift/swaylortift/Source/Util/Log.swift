/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import UIKit


public enum LogLevel:UInt
{
	case System  = 0
	case Trace   = 1
	case Debug   = 2
	case Info    = 3
	case Notice  = 4
	case Warning = 5
	case Error   = 6
	case Fatal   = 7
}


public struct LogMode:OptionSet
{
	public let rawValue:UInt

	public init(rawValue:UInt) { self.rawValue = rawValue }

	public static let None = LogMode(rawValue: 0)
	public static let FileName = LogMode(rawValue: 1 << 0)
	public static let FuncName = LogMode(rawValue: 1 << 1)
	public static let Line = LogMode(rawValue: 1 << 2)
	public static let Date = LogMode(rawValue: 1 << 3)
	
	public static let AllOptions:LogMode = [Date, FileName, FuncName, Line]
	public static let FullCodeLocation:LogMode = [FileName, FuncName, Line]
}


public struct Log
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public static let DELIMITER = "----------------------------------------------------------------------------------------------------"
	public static let DELIMITER_STRONG = "===================================================================================================="
	public static let DEFAULT_CATEGORY = ""
	
	public static var mode:LogMode = .None
	public static var enabled = true
	public static var logLevel = LogLevel.System
	public static var prompt = "> "
	public static var separator = " "
	public static var terminator = "\n"
	
	public static var logFilePath:String?
	public static var logFile:LogFile?
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Logging API
	// ----------------------------------------------------------------------------------------------------
	
	public static func system(_ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.System.rawValue) { return }
		output(DEFAULT_CATEGORY, LogLevel.System, items: items, file: file, function: function, line: line)
	}
	
	
	public static func system(category:String = DEFAULT_CATEGORY, _ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.System.rawValue) { return }
		output(category, LogLevel.System, items: items, file: file, function: function, line: line)
	}
	
	
	public static func trace(_ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Trace.rawValue) { return }
		output(DEFAULT_CATEGORY, LogLevel.Trace, items: items, file: file, function: function, line: line)
	}


	public static func trace(category:String = DEFAULT_CATEGORY, _ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Trace.rawValue) { return }
		output(category, LogLevel.Trace, items: items, file: file, function: function, line: line)
	}
	
	
	public static func debug(_ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Debug.rawValue) { return }
		output(DEFAULT_CATEGORY, LogLevel.Debug, items: items, file: file, function: function, line: line)
	}
	
	
	public static func debug(category:String = DEFAULT_CATEGORY, _ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Debug.rawValue) { return }
		output(category, LogLevel.Debug, items: items, file: file, function: function, line: line)
	}
	
	
	public static func info(_ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Info.rawValue) { return }
		output(DEFAULT_CATEGORY, LogLevel.Info, items: items, file: file, function: function, line: line)
	}
	
	
	public static func info(category:String = DEFAULT_CATEGORY, _ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Info.rawValue) { return }
		output(category, LogLevel.Info, items: items, file: file, function: function, line: line)
	}
	
	
	public static func notice(_ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Notice.rawValue) { return }
		output(DEFAULT_CATEGORY, LogLevel.Notice, items: items, file: file, function: function, line: line)
	}
	
	
	public static func notice(category:String = DEFAULT_CATEGORY, _ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Notice.rawValue) { return }
		output(category, LogLevel.Notice, items: items, file: file, function: function, line: line)
	}
	
	
	public static func warning(_ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Warning.rawValue) { return }
		output(DEFAULT_CATEGORY, LogLevel.Warning, items: items, file: file, function: function, line: line)
	}
	
	
	public static func warning(category:String = DEFAULT_CATEGORY, _ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Warning.rawValue) { return }
		output(category, LogLevel.Warning, items: items, file: file, function: function, line: line)
	}
	
	
	public static func error(_ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Error.rawValue) { return }
		output(DEFAULT_CATEGORY, LogLevel.Error, items: items, file: file, function: function, line: line)
	}
	
	
	public static func error(category:String = DEFAULT_CATEGORY, _ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Error.rawValue) { return }
		output(category, LogLevel.Error, items: items, file: file, function: function, line: line)
	}
	
	
	public static func fatal(_ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Fatal.rawValue) { return }
		output(DEFAULT_CATEGORY, LogLevel.Fatal, items: items, file: file, function: function, line: line)
	}
	
	
	public static func fatal(category:String = DEFAULT_CATEGORY, _ items:Any..., file:String = #file, function:String = #function, line:Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Fatal.rawValue) { return }
		output(category, LogLevel.Fatal, items: items, file: file, function: function, line: line)
	}
	
	
	public static func delimiter()
	{
		if (!enabled) { return }
		output(DEFAULT_CATEGORY, LogLevel.Trace, items: [Log.DELIMITER])
	}
	
	
	public static func delimiter(category:String = DEFAULT_CATEGORY)
	{
		if (!enabled) { return }
		output(category, LogLevel.Trace, items: [Log.DELIMITER])
	}
	
	
	public static func delimiterStrong()
	{
		if (!enabled) { return }
		output(DEFAULT_CATEGORY, LogLevel.Trace, items: [Log.DELIMITER_STRONG])
	}
	
	
	public static func delimiterStrong(category:String = DEFAULT_CATEGORY)
	{
		if (!enabled) { return }
		output(category, LogLevel.Trace, items: [Log.DELIMITER_STRONG])
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Private Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * print items to the console
	 * - parameter items:      items to print
	 */
	private static func output(_ category:String, _ logLevel:LogLevel, items:[Any], file:String? = nil, function:String? = nil, line:Int? = nil)
	{
		let prefix = modePrefix(Date(), file: file, function: function, line: line)
		let stringItem = items.map { "\($0)" }.joined(separator: Log.separator)
		let line = "\(category)\(Log.prompt)\(Log.getLogLevelName(logLevel: logLevel))\(prefix)\(stringItem)"
		Swift.print(line, terminator: Log.terminator)
		
		if let logFilePath = Log.logFilePath
		{
			if Log.logFile == nil
			{
				Log.logFile = LogFile(logFilePath)
				_ = Log.logFile!.delete()
			}
			if let logFile = Log.logFile
			{
				_ = logFile.append(content: "\(line)\(Log.terminator)")
			}
		}
	}
	
	
	private static func getLogLevelName(logLevel:LogLevel) -> String
	{
		switch (logLevel)
		{
			case LogLevel.System:  return " [SYSTEM]  "
			case LogLevel.Trace:   return " [TRACE]   "
			case LogLevel.Debug:   return " [DEBUG]   "
			case LogLevel.Info:    return " [INFO]    "
			case LogLevel.Notice:  return " [NOTICE]  "
			case LogLevel.Warning: return " [WARNING] "
			case LogLevel.Error:   return " [ERROR]   "
			case LogLevel.Fatal:   return " [FATAL]   "
		}
	}
}


// ------------------------------------------------------------------------------------------------
protocol RGBColorType
{
	/// Return RGB color represenation.
	/// Example R: 200, G: 125, G: 255
	var colorCode:String
	{
		get
	}
}


// ------------------------------------------------------------------------------------------------
struct ColorLog
{
	struct Key
	{
		fileprivate static let Escape = "\u{001b}["
		fileprivate static let Fg = "fg"
		static let Bg = "bg"
		
		static let StartFg = "\(Escape)\(Fg)"
		static let StartBg = "\(Escape)\(Bg)"
		
		static let ResetFG = Escape + "fg;"
		// Clear any foreground color
		static let ResetBG = Escape + "bg;"
		// Clear any background color
		static let Reset = Escape + ";"
		// Clear any foreground or background color
	}
	
	
	/// String with a Font color
	static func font<T>(_ color:RGBColorType, object:T) -> String
	{
		return "\(Key.StartFg)\(color.colorCode);\(object)\(Key.Reset)"
	}
	
	
	/// String with a Background color
	static func background<T>(_ color:RGBColorType, object:T) -> String
	{
		return "\(Key.StartBg)\(color.colorCode);\(object)\(Key.Reset)"
	}
	
	
	/// String with both Background and Font color
	static func colored<T>(_ font:RGBColorType, background:RGBColorType, object:T) -> String
	{
		let string =
				"\(Key.Escape)fg\(font.colorCode);" +
						"\(Key.Escape)bg\(background.colorCode);" +
						"\(object)\(Key.Reset)"
		
		return string
	}
}


// ------------------------------------------------------------------------------------------------
extension Log
{
	/// Create an output string for the currect log Mode
	static func modePrefix(_ date:Date, file:String?, function:String?, line:Int?) -> String
	{
		var result:String = String.Empty
		if mode.contains(.Date)
		{
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
			let s = formatter.string(from: date)
			result += s
		}
		if mode.contains(.FileName)
		{
			if let file = file { result += "\(file.lastPathComponent.stringByDeletingPathExtension)." }
		}
		if mode.contains(.FuncName)
		{
			if let function = function { result += "\(function)" }
		}
		if mode.contains(.Line)
		{
			if let line = line { result += "[\(line)]" }
		}
		
		if !result.isEmpty
		{
			result = result.trimmingCharacters(in: CharacterSet.whitespaces)
			result += ": "
		}
		
		return result
	}
}


// ------------------------------------------------------------------------------------------------
public extension Log
{
	/// Use custom UIColor desription
	static func enableVisualColorLog()
	{
		UIColor.swizzleDescription()
	}
	
	
	/// Restore default UIColor desription
	static func disableVisualColorLog()
	{
		UIColor.undoDesriptionSwizzling()
	}
}
