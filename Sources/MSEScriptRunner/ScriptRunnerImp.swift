// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class ScriptRunnerImp: ScriptRunner {
    public var password: String?
    private let normalRunner: ScriptRunnerNormal
    private let rootRunner: ScriptRunnerRoot
    
    public init(password: String? = nil) {
        self.password = password
        self.normalRunner = ScriptRunnerNormalImp()
        self.rootRunner = ScriptRunnerRootImp()
    }
    
    public func excecuteCommandWithSudoInLiveMode(input: String) async -> ScriptResponse {
        let result = await self.rootRunner.excecuteCommandWithSudoInLiveMode(input: input, password: self.password)
        return result
    }
    
    public func excecuteCommandWithSudo(input: String) async -> ScriptResponse {
        let result = await self.rootRunner.excecuteCommandWithSudo(input: input, password: self.password)
        return result
    }
    
    public func excecuteCommand(input: String) async -> ScriptResponse {
        let result = await self.normalRunner.excecuteCommand(input: input)
        return result
    }
    
    public func validateAccountRootPrivilege() async -> Bool {
        let result = await self.rootRunner.validateAccountRootPrivilege(password: self.password)
        return result
    }
    
    public func getCurrentLoggedInUsername() async -> String? {
        let result = await self.normalRunner.getCurrentLoggedInUsername()
        return result
    }
}
