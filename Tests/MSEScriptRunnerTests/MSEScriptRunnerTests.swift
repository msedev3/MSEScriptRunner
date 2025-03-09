import Testing
import XCTest
@testable import MSEScriptRunner

final class ScriptRunnerTests: XCTestCase {
    func testExample() async throws{
        let scriptRunner: ScriptRunner = ScriptRunnerImp(password: "213456")
        let result = await scriptRunner.excecuteCommand(input: "ls")
        XCTAssertEqual(result.status, 0, "Command execution failed with status code \(result.status). Output: \(String(describing: result.output))")
    }
}
