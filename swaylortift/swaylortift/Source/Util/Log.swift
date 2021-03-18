/*    ____                 __           _______ _____
 *   / __/    _____ ___ __/ /__  ____  /_  __(_) _/ /_
 *  _\ \| |/|/ / _ `/ // / / _ \/ __/   / / / / _/ __/
 * /___/|__,__/\_,_/\_, /_/\___/_/     /_/ /_/_/ \__/
 *                 /___/
 * Utils & Extensions for Swift Projects
 * (c) 2018 Ciathyza
 */

import UIKit


public enum LogLevel: UInt
{
	case System = 0
	case Trace = 1
	case Debug = 2
	case Info = 3
	case Notice = 4
	case Warning = 5
	case Error = 6
	case Fatal = 7
}


public struct LogMode: OptionSet
{
	public let rawValue: UInt


	public init(rawValue: UInt)
	{
		self.rawValue = rawValue
	}


	public static let None     = LogMode([])
	public static let FileName = LogMode(rawValue: 1 << 0)
	public static let FuncName = LogMode(rawValue: 1 << 1)
	public static let Line     = LogMode(rawValue: 1 << 2)
	public static let Date     = LogMode(rawValue: 1 << 3)

	public static let AllOptions: LogMode = [Date, FileName, FuncName, Line]
	public static let FullCodeLocation: LogMode = [FileName, FuncName, Line]
}


public struct Log
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------

	public static let DELIMITER = "----------------------------------------------------------------------------------------------------"
	public static let DELIMITER_STRONG = "===================================================================================================="
	public static let DEFAULT_CATEGORY = String.Empty

	public static var mode: LogMode      = .None
	public static var enabled            = true
	public static var useAsyncFileAccess = true
	public static var logLevel           = LogLevel.System
	public static var prompt             = "> "
	public static var separator          = String.Space
	public static var terminator         = String.LF

	public static var logFilePath: String?
	public static var logFile: LogFile?

	// Toggles log-writing to file. Will also be disabled if not enough free space available on disk.
	public static var fileLoggingEnabled = true
	// Minimum free disk space required (in MB) to write to log file.
	public static var fileLoggingMinFreeDiskSpaceRequired: Int64  = 100


	// ----------------------------------------------------------------------------------------------------
	// MARK: - Logging API
	// ----------------------------------------------------------------------------------------------------

	public static func system(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.System.rawValue) { return }
		output(logLevel: LogLevel.System, items: items, category: DEFAULT_CATEGORY, file: file, function: function, line: line)
	}


	public static func system(category: String = DEFAULT_CATEGORY, _ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.System.rawValue) { return }
		output(logLevel: LogLevel.System, items: items, category: category, file: file, function: function, line: line)
	}


	public static func trace(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Trace.rawValue) { return }
		output(logLevel: LogLevel.Trace, items: items, category: DEFAULT_CATEGORY, file: file, function: function, line: line)
	}


	public static func trace(category: String = DEFAULT_CATEGORY, _ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Trace.rawValue) { return }
		output(logLevel: LogLevel.Trace, items: items, category: category, file: file, function: function, line: line)
	}


	public static func debug(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Debug.rawValue) { return }
		output(logLevel: LogLevel.Debug, items: items, category: DEFAULT_CATEGORY, file: file, function: function, line: line)
	}


	public static func debug(category: String = DEFAULT_CATEGORY, _ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Debug.rawValue) { return }
		output(logLevel: LogLevel.Debug, items: items, category: category, file: file, function: function, line: line)
	}


	public static func info(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Info.rawValue) { return }
		output(logLevel: LogLevel.Info, items: items, category: DEFAULT_CATEGORY, file: file, function: function, line: line)
	}


	public static func info(category: String = DEFAULT_CATEGORY, _ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Info.rawValue) { return }
		output(logLevel: LogLevel.Info, items: items, category: category, file: file, function: function, line: line)
	}


	public static func notice(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Notice.rawValue) { return }
		output(logLevel: LogLevel.Notice, items: items, category: DEFAULT_CATEGORY, file: file, function: function, line: line)
	}


	public static func notice(category: String = DEFAULT_CATEGORY, _ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Notice.rawValue) { return }
		output(logLevel: LogLevel.Notice, items: items, category: category, file: file, function: function, line: line)
	}


	public static func warning(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Warning.rawValue) { return }
		output(logLevel: LogLevel.Warning, items: items, category: DEFAULT_CATEGORY, file: file, function: function, line: line)
	}


	public static func warning(category: String = DEFAULT_CATEGORY, _ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Warning.rawValue) { return }
		output(logLevel: LogLevel.Warning, items: items, category: category, file: file, function: function, line: line)
	}


	public static func error(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Error.rawValue) { return }
		output(logLevel: LogLevel.Error, items: items, category: DEFAULT_CATEGORY, file: file, function: function, line: line)
	}


	public static func error(category: String = DEFAULT_CATEGORY, _ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Error.rawValue) { return }
		output(logLevel: LogLevel.Error, items: items, category: category, file: file, function: function, line: line)
	}


	public static func fatal(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Fatal.rawValue) { return }
		output(logLevel: LogLevel.Fatal, items: items, category: DEFAULT_CATEGORY, file: file, function: function, line: line)
	}


	public static func fatal(category: String = DEFAULT_CATEGORY, _ items: Any..., file: String = #file, function: String = #function, line: Int = #line)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Fatal.rawValue) { return }
		output(logLevel: LogLevel.Fatal, items: items, category: category, file: file, function: function, line: line)
	}


	public static func delimiter()
	{
		if (!enabled) { return }
		output(logLevel: LogLevel.Debug, items: [Log.DELIMITER], category: DEFAULT_CATEGORY)
	}


	public static func delimiter(category: String = DEFAULT_CATEGORY)
	{
		if (!enabled) { return }
		output(logLevel: LogLevel.Debug, items: [Log.DELIMITER], category: category)
	}


	public static func delimiterStrong()
	{
		if (!enabled) { return }
		output(logLevel: LogLevel.Debug, items: [Log.DELIMITER_STRONG], category: DEFAULT_CATEGORY)
	}


	public static func delimiterStrong(category: String = DEFAULT_CATEGORY)
	{
		if (!enabled) { return }
		output(logLevel: LogLevel.Debug, items: [Log.DELIMITER_STRONG], category: category)
	}


	// ----------------------------------------------------------------------------------------------------
	// MARK: - Private Methods
	// ----------------------------------------------------------------------------------------------------

	private static func log(_ line: String)
	{
		if let logFilePath = Log.logFilePath
		{
			if Log.logFile == nil
			{
				Log.logFile = LogFile(logFilePath)
				if Log.useAsyncFileAccess
				{
					DispatchQueue.main.async { _ = Log.logFile!.delete() }
				}
				else
				{
					_ = Log.logFile!.delete()
				}
			}
			if let logFile = Log.logFile
			{
				if Log.useAsyncFileAccess
				{
					DispatchQueue.main.async { _ = logFile.append(content: "\(line)\(Log.terminator)") }
				}
				else
				{
					_ = logFile.append(content: "\(line)\(Log.terminator)")
				}
			}
		}
	}

	private static func output(logLevel: LogLevel, items: [Any], category: String, file: String? = nil, function: String? = nil, line: Int? = nil)
	{
		let prefix = modePrefix(Date(), file: file, function: function, line: line)
		let itemsString = items.map { "\($0)" }.joined(separator: Log.separator)
		let cat = category.isEmpty ? category : category + String.Space
		let line = "\(Log.prompt)\(Log.getLogLevelName(logLevel))\(cat)\(prefix)\(itemsString)"

		Swift.print(line, terminator: Log.terminator)

		// Check if minFreeDiskSpaceRequired condition is met
		if Log.fileLoggingEnabled
		{
			guard FileManager.default.availableDiskSpaceInMB() > Log.fileLoggingMinFreeDiskSpaceRequired else
			{
				Log.fileLoggingEnabled = false
				let errorLine = "\(Log.prompt)\(Log.getLogLevelName(LogLevel.Error))\(prefix)Unable to write logs. Disk memory less than \(Log.fileLoggingMinFreeDiskSpaceRequired) MB."
				Swift.print(errorLine, terminator: Log.terminator)
				log(errorLine)
				return
			}
		}

		log(line)
	}


	private static func getLogLevelName(_ logLevel: LogLevel) -> String
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
	var colorCode: String { get }
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
		static let ResetFG = Escape + "fg;" // Clear any foreground color
		static let ResetBG = Escape + "bg;" // Clear any background color
		static let Reset = Escape + ";"     // Clear any foreground or background color
	}


	/// String with a Font color
	static func font<T>(_ color: RGBColorType, object: T) -> String
	{
		"\(Key.StartFg)\(color.colorCode);\(object)\(Key.Reset)"
	}


	/// String with a Background color
	static func background<T>(_ color: RGBColorType, object: T) -> String
	{
		"\(Key.StartBg)\(color.colorCode);\(object)\(Key.Reset)"
	}


	/// String with both Background and Font color
	static func colored<T>(_ font: RGBColorType, background: RGBColorType, object: T) -> String
	{
		let string = "\(Key.Escape)fg\(font.colorCode);" + "\(Key.Escape)bg\(background.colorCode);" + "\(object)\(Key.Reset)"
		return string
	}
}


// ------------------------------------------------------------------------------------------------
extension Log
{
	/// Create an output string for the currect log Mode
	static func modePrefix(_ date: Date, file: String?, function: String?, line: Int?) -> String
	{
		var result: String = String.Empty
		if mode.contains(.Date)
		{
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
			let s = formatter.string(from: date)
			result += s
		}
		if mode.contains(.FileName)
		{
			if let file = file
			{
				result += "\(file.lastPathComponent.stringByDeletingPathExtension)."
			}
		}
		if mode.contains(.FuncName)
		{
			if let function = function
			{
				result += "\(function)"
			}
		}
		if mode.contains(.Line)
		{
			if let line = line
			{
				result += "[\(line)]"
			}
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
	/// Use custom UIColor description
	static func enableVisualColorLog()
	{
		if #available(macCatalyst 13.0, *)
		{
			UIColor.swizzleDescription()
		}
		else
		{
			// Fallback on earlier versions
			Swift.print("[ERROR] Operation not supported: UIColor.swizzleDescription", terminator: Log.terminator)
		}
	}


	/// Restore default UIColor description
	static func disableVisualColorLog()
	{
		if #available(macCatalyst 13.0, *)
		{
			UIColor.undoDesriptionSwizzling()
		}
		else
		{
			// Fallback on earlier versions
			Swift.print("[ERROR] Operation not supported: UIColor.undoDesriptionSwizzling", terminator: Log.terminator)
		}
	}
}
