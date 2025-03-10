//
//  File.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 11/14/1403 AP.
//
import Foundation

internal extension String {
    /// Removes the specified prefix from the string if it exists.
    /// - Parameter prefix: The prefix to remove.
    /// - Returns: The string with the prefix removed, or the original string if the prefix does not exist.
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    /// Trims whitespace and newline characters from the start and end of the string.
    /// - Returns: The trimmed string.
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
