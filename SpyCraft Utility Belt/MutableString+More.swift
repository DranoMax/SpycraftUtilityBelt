//
//  MutableString+More.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/23/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import Foundation

extension NSMutableString {
    
    public func capturedGroups(withRegex pattern: String) -> [String] {
        var results = [String]()
        let string = String(self)
        
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }
        
        let matches = regex.matches(in: string, options: [], range: NSRange(location:0, length: string.characters.count))
        
        guard let match = matches.first else { return results }
                let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }
        

        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.rangeAt(i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }
        
        return results
    }
    
    public func matches(for regex: String) -> [String] {
        let string = String(self)
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = string as NSString
            let results = regex.matches(in: string, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
