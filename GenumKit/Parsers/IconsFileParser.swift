//
//  IconsFileParser.swift
//  Pods
//
//  Created by Ignacio Romero on 5/23/16.
//
//

import Foundation

public protocol IconsFileParser {
    var icons: Dictionary<String, String> { get }
}

// MARK: - JSON File Parser

public final class IconsJSONFileParser: IconsFileParser {
    
    public var icons = Dictionary<String, String>()
    
    public init() {}
    
    public func parseFile(path: String) throws {
        if let JSONdata = NSData(contentsOfFile: path),
            let json = try? NSJSONSerialization.JSONObjectWithData(JSONdata, options: []),
            let dict = json as? [String: String] {
            for (key, value) in dict {
                icons[key] = value
            }
        }
    }
}