//
//  File.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 11/14/1403 AP.
//

import Foundation

/// Represents the result of executing a shell command.
public struct ScriptResponse {
    /// The standard output of the command (if any).
    public let output: String?
    
    /// The error message (if any).
    public let error: String?
    
    /// The exit code of the command.
    public let exitCode: Int32
    
    /// Indicates whether the command executed successfully (exitCode == 0).
    public let isSuccess: Bool

    /// Initializes a new `ScriptResponse`.
    /// - Parameters:
    ///   - output: The command's standard output.
    ///   - error: The command's error output.
    ///   - exitCode: The command's exit code.
    public init(output: String? = nil, error: String? = nil, exitCode: Int32) {
        self.output = output
        self.error = error
        self.exitCode = exitCode
        self.isSuccess = exitCode == 0 // A command is successful if the exit code is 0.
    }
}
