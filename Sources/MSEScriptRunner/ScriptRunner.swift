//
//  ScriptRunner.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 11/14/1403 AP.
//


public protocol ScriptRunner {
    var password: String?{get}
    
    func excecuteCommandWithSudoInLiveMode(input: String) async -> ScriptResponse
    func excecuteCommandWithSudo(input: String) async  -> ScriptResponse
    func excecuteCommand(input: String) async  -> ScriptResponse
    func validateAccountRootPrivilege() async -> Bool
    func getCurrentLoggedInUsername() async -> String?
}

public protocol ScriptRunnerNormal {
    func excecuteCommand(input: String) async -> ScriptResponse
    func getCurrentLoggedInUsername() async -> String?
}

public protocol ScriptRunnerRoot {
    func excecuteCommandWithSudoInLiveMode(input: String, password: String?) async ->ScriptResponse
    func excecuteCommandWithSudo(input: String, password: String?) async -> ScriptResponse
    func validateAccountRootPrivilege(password: String?) async -> Bool
}
