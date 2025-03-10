//
//  ScriptRunner.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 11/14/1403 AP.
//


import Foundation

/// Protocol defining the interface for a script runner that supports both normal and sudo commands.
public protocol ScriptRunnerInterface {
    /// The password for sudo commands (optional).
    var password: String? { get }
    
    /// Executes a sudo command in live mode (streams output in real-time).
    func excecuteCommandWithSudoInLiveMode(input: String) async -> ScriptResponse
    
    /// Executes a sudo command and returns the result.
    func excecuteCommandWithSudo(input: String) async -> ScriptResponse
    
    /// Executes a normal command and returns the result.
    func excecuteCommand(input: String) async -> ScriptResponse
    
    /// Validates if the current account has root privileges.
    func validateAccountRootPrivilege() async -> Bool
    
    /// Retrieves the currently logged-in username.
    func getCurrentLoggedInUsername() async -> String?
}

/// Protocol defining the interface for a script runner that handles normal commands.
internal protocol ScriptRunnerNormal {
    /// Executes a normal command and returns the result.
    func excecuteCommand(input: String) async -> ScriptResponse
    
    /// Retrieves the currently logged-in username.
    func getCurrentLoggedInUsername() async -> String?
}

/// Protocol defining the interface for a script runner that handles sudo commands.
internal protocol ScriptRunnerRoot {
    /// Executes a sudo command in live mode (streams output in real-time).
    func excecuteCommandWithSudoInLiveMode(input: String, password: String?) async -> ScriptResponse
    
    /// Executes a sudo command and returns the result.
    func excecuteCommandWithSudo(input: String, password: String?) async -> ScriptResponse
    
    /// Validates if the provided password grants root privileges.
    func validateAccountRootPrivilege(password: String?) async -> Bool
}
