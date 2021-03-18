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

	// Log mode used for log statements. See LogMode. By default uses no code location or time stamp.
	public static var mode: LogMode = .None

	// Enables or disables the log functionality
	public static var enabled = true

	// Default minimum log filter level. Everything below this log level is omitted from logging.
	public static var logLevel = LogLevel.System

	// Prompt string used to designate the beginning of a new log statement line.
	public static var prompt = "> "

	// Separator string used between different components in a log staement,
	public static var separator = String.Space

	// EOL terminator used for log statements in screen and file logs.
	public static var terminator = String.LF

	// If set to false will not log to screen output. Can be used to only log to log file.
	public static var screenLoggingEnabled = true

	// Path to the log file being written on disk.
	public static var logFilePath: String?

	// The maximum size a log file may reach. Default is 100 mb. Set to 0 for unlimited (not recommended).
	public static var logFileMaxSize = Filesize(megabyte: 100.0)

	// Reference to log file, if enabled
	public static var logFile: LogFile?

	// Toggles log-writing to file. Disabled by default. Will also be disabled if not enough free space available on disk.
	public static var fileLoggingEnabled = false

	// If set to true disables the logger completely if file log max size/disk near full was reached. Default: false
	public static var disableLogOnFileLogFull = false

	// Minimum free disk space required (in MB) to write to log file. Default is 2gb.
	public static var fileLoggingMinFreeDiskSpaceRequired = Filesize(gigabyte: 2.0)

	private static let _serialQueue = DispatchQueue(label: "swaylortift.queue.serial", qos: .default)


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

	private static func output(logLevel: LogLevel, items: [Any], category: String, file: String? = nil, function: String? = nil, line: Int? = nil)
	{
		let prefix = modePrefix(Date(), file: file, function: function, line: line)
		let itemsString = items.map { "\($0)" }.joined(separator: Log.separator)
		let cat = category.isEmpty ? category : category + String.Space
		let statement = "\(Log.prompt)\(Log.getLogLevelName(logLevel))\(cat)\(prefix)\(itemsString)"

		if Log.screenLoggingEnabled { Swift.print(statement, terminator: Log.terminator) }
		if Log.fileLoggingEnabled { logToFile(statement) }
	}


	private static func logToFile(_ statement: String)
	{
		/* Check if minFreeDiskSpaceRequired condition is met */
		guard FileManager.default.availableDiskSpace.byte > Log.fileLoggingMinFreeDiskSpaceRequired.byte else
		{
			output(logLevel: .Error, items: ["Unable to write logs. Disk space is less than \(Log.fileLoggingMinFreeDiskSpaceRequired.readableUnit). File-logging disabled!"], category: DEFAULT_CATEGORY)
			Log.fileLoggingEnabled = false
			if Log.disableLogOnFileLogFull { Log.enabled = false }
			return
		}

		if let logFilePath = Log.logFilePath
		{
			/* Create new log file, if not yet done. */
			if Log.logFile == nil
			{
				Log.logFile = LogFile(logFilePath)
				_serialQueue.async { _ = Log.logFile!.delete() }
			}

			if let logFile = Log.logFile
			{
				_serialQueue.async
				{
					/* Check if max. log file size was reached. */
					guard logFile.fileSize.byte < 1 || logFile.fileSize.byte < Log.logFileMaxSize.byte else
					{
						output(logLevel: .Warning, items: ["Log file max size reached (\(Log.logFileMaxSize.readableUnit)). File-logging disabled!"], category: DEFAULT_CATEGORY)
						Log.fileLoggingEnabled = false
						if Log.disableLogOnFileLogFull { Log.enabled = false }
						return
					}

					let success = logFile.append(content: "\(statement)\(Log.terminator)")
					/* If last log writing was not successful, disable file logging! */
					if !success { Log.fileLoggingEnabled = false }
				}
			}
		}
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
