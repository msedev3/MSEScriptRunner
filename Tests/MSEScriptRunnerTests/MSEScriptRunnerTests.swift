import Testing
import XCTest
@testable import MSEScriptRunner

final class ScriptRunnerTests: XCTestCase {
    func testExample() async throws{
        let scriptRunner: ScriptRunner = ScriptRunnerImp(password: "213456")
        let result = await scriptRunner.excecuteCommand(input: "ls")
        XCTAssertEqual(result.exitCode, 0, "Command execution failed with status code \(result.exitCode). Output: \(String(describing: result.output))")
    }
    
    func testUserName() async {
        let scriptRunner: ScriptRunner = ScriptRunnerImp(password: "213456")
        let result = await scriptRunner.getCurrentLoggedInUsername()
        XCTAssertEqual(result, "Moosa", "Command execution failed with status code \(result ?? "")")
    }
}
