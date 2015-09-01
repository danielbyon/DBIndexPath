//
//  DBIndexPath.swift
//
//  Copyright (c) 2015 Daniel Byon
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit

private let _separator = ","

public struct DBIndexPath: Equatable {
    
    // MARK: Variables
    
    public var section: Int
    public var row: Int
    
    // MARK: Initializers
    
    /**
    Designated initializer
    
    :param: section Section
    :param: row     Row
    
    :returns: An initialized DBIndexPath struct
    */
    public init(section: Int, row: Int) {
        self.section = section
        self.row = row
    }
    
    /**
    Initializer that takes an NSIndexPath. Typically, you would call this inside a UITableViewDataSource/UITableViewDelegate
    method, passing in the NSIndexPath you were given from the protocol method.
    
    :param: indexPath An NSIndexPath object, must have only two indices
    
    :returns: An initialized DBIndexPath struct iff indexPath has two indices
    */
    public init?(_ indexPath: NSIndexPath) {
        guard indexPath.length == 2 else { return nil }
        let section = indexPath.indexAtPosition(0)
        let row = indexPath.indexAtPosition(1)
        self.init(section: section, row: row)
    }
    
}

// MARK: - RawRepresentable
extension DBIndexPath: RawRepresentable {
    
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        let elements = (rawValue as NSString).componentsSeparatedByString(_separator)
        guard elements.count == 2 else { return nil }
        guard let section = Int(elements[0]) else { return nil }
        guard let row = Int(elements[1]) else { return nil }
        self.init(section: section, row: row)
    }
    
    public var rawValue: RawValue {
        return "\(section)\(_separator)\(row)"
    }
    
}

// MARK: StringLiteralConvertible
extension DBIndexPath: StringLiteralConvertible {
    
    public typealias StringLiteralType = String
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias UnicodeScalarLiteralType = String
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: value)!
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
    
}

// MARK: CustomStringConvertible
extension DBIndexPath: CustomStringConvertible {
    
    public var description: String {
        return rawValue
    }
    
}

// MARK: CustomDebugStringPrintable
extension DBIndexPath: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "section: '\(section)', row: '\(row)'"
    }
    
}

// MARK: - Equatable
public func ==(lhs: DBIndexPath, rhs: DBIndexPath) -> Bool {
    return lhs.section == rhs.section
        && lhs.row == rhs.row
}
