//
// Filesize.swift
// swaylortift
//
// Copyright (c) 2021 Ciathyza. All rights reserved.
//

import Foundation


public struct Filesize
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: Properties
	// ----------------------------------------------------------------------------------------------------

	public let byte: Int64
	public var kilobyte: Double { Double(byte) / 1_024 }
	public var megabyte: Double { kilobyte / 1_024 }
	public var gigabyte: Double { megabyte / 1_024 }


	// ----------------------------------------------------------------------------------------------------
	// MARK: Accessors
	// ----------------------------------------------------------------------------------------------------

	public var readableUnit: String
	{
		switch byte
		{
			case 0 ..< 1_024:
				return "\(byte) bytes"
			case 1_024 ..< (1_024 * 1_024):
				return "\(String(format: "%.2f", kilobyte)) kb"
			case 1_024 ..< (1_024 * 1_024 * 1_024):
				return "\(String(format: "%.2f", megabyte)) mb"
			case (1_024 * 1_024 * 1_024) ... Int64.max:
				return "\(String(format: "%.2f", gigabyte)) gb"
			default:
				return "\(byte) bytes"
		}
	}


	// ----------------------------------------------------------------------------------------------------
	// MARK: Init
	// ----------------------------------------------------------------------------------------------------

	public init(byte: Int64)
	{
		self.byte = byte
	}


	public init(kilobyte: Double)
	{
		byte = Int64(kilobyte * 1_024)
	}


	public init(megabyte: Double)
	{
		byte = Int64(megabyte * 1_024 * 1_024)
	}


	public init(gigabyte: Double)
	{
		byte = Int64(gigabyte * 1_024 * 1_024 * 1_024)
	}


	// ----------------------------------------------------------------------------------------------------
	// MARK: Methods
	// ----------------------------------------------------------------------------------------------------

	public func toString() -> String
	{
		"[Filesize byte=\(byte), kilobyte=\(kilobyte), megabyte=\(megabyte), gigabyte=\(gigabyte)]"
	}
}
