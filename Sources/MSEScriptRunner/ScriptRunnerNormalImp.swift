//
//  ScriptRunnerNormalImp.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 12/14/1403 AP.
//

import Foundation

/// Implementation of the `ScriptRunnerNormal` protocol.
internal class ScriptRunnerNormalImp: ScriptRunnerNormal {
    
    /// Retrieves the currently logged-in username.
    internal func getCurrentLoggedInUsername() async -> String? {
        return NSUserName() // Returns the username of the currently logged-in user.
    }
    
    /// Executes a normal command and returns the result.
    internal func excecuteCommand(input: String) async -> ScriptResponse {
        let task = Process()
        let outputPipe = Pipe()
        
        // Configure the process to execute the command.
        task.launchPath = "/usr/bin/env" // Use `/usr/bin/env` to ensure compatibility.
        task.arguments = ["/bin/bash", "-c", input] // Pass the command as an argument to bash.
        task.standardOutput = outputPipe // Capture the standard output.
        
        // Launch the process and capture the output.
        task.launch()
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: outputData, encoding: .utf8) else {
            print("An error occurred while casting the command output to a string")
            return ScriptResponse(exitCode: task.terminationStatus)
        }
        
        task.waitUntilExit() // Wait for the process to complete.
        return ScriptResponse(output: output, exitCode: task.terminationStatus)
    }
    
    /// Executes a command as a specific user without sudo.
    internal func runScriptWithOutSudoWithUsername(input: String, userName: String) async -> ScriptResponse {
        let task = Process()
        let stdOut = Pipe()
        let stdIn = Pipe()
        
        // Configure the process to execute the command as the specified user.
        task.launchPath = "/usr/bin/sudo"
        task.standardOutput = stdOut
        task.standardError = stdOut
        task.standardInput = stdIn
        task.arguments = ["-u", userName, "/bin/bash", "-c", "-l", input]
        
        try? task.run() // Run the process.
        
        // Capture the output.
        let outputData = stdOut.fileHandleForReading.readDataToEndOfFile()
        var output = String(data: outputData, encoding: .utf8)
        print("actual output is ", output ?? "")
        if let outputTemp = output {
            output = outputTemp.deletingPrefix("Password:") // Remove the "Password:" prefix from the output.
        }
        task.waitUntilExit()
        print("status code is \(task.terminationStatus)")
        print("result is ", output ?? "")
        return ScriptResponse(output: output?.trim(), exitCode: task.terminationStatus)
    }
}
