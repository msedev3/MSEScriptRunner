// The Swift Programming Language
// https://docs.swift.org/swift-book

/// Implementation of the `ScriptRunner` protocol.
public class ScriptRunner: ScriptRunnerInterface {
    public var password: String?
    private let normalRunner: ScriptRunnerNormal
    private let rootRunner: ScriptRunnerRoot
    
    /// Initializes a new `ScriptRunnerImp`.
    /// - Parameter password: The password for sudo commands (optional).
    public init(password: String? = nil) {
        self.password = password
        self.normalRunner = ScriptRunnerNormalImp()
        self.rootRunner = ScriptRunnerRootImp()
    }
    
    /// Executes a sudo command in live mode (streams output in real-time).
    public func excecuteCommandWithSudoInLiveMode(input: String) async -> ScriptResponse {
        let result = await self.rootRunner.excecuteCommandWithSudoInLiveMode(input: input, password: self.password)
        return result
    }
    
    /// Executes a sudo command and returns the result.
    public func excecuteCommandWithSudo(input: String) async -> ScriptResponse {
        let result = await self.rootRunner.excecuteCommandWithSudo(input: input, password: self.password)
        return result
    }
    
    /// Executes a normal command and returns the result.
    public func excecuteCommand(input: String) async -> ScriptResponse {
        let result = await self.normalRunner.excecuteCommand(input: input)
        return result
    }
    
    /// Validates if the current account has root privileges.
    public func validateAccountRootPrivilege() async -> Bool {
        let result = await self.rootRunner.validateAccountRootPrivilege(password: self.password)
        return result
    }
    
    /// Retrieves the currently logged-in username.
    public func getCurrentLoggedInUsername() async -> String? {
        let result = await self.normalRunner.getCurrentLoggedInUsername()
        return result
    }
}
