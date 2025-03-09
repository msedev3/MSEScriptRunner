//
//  File.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 11/14/1403 AP.
//
import Foundation

public extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
