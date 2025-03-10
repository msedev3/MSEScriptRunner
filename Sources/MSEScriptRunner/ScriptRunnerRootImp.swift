//
//  ScriptRunnerRootImp.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 12/14/1403 AP.
//

import Foundation

/// Implementation of the `ScriptRunnerRoot` protocol.
internal class ScriptRunnerRootImp: ScriptRunnerRoot {
    /// Executes a sudo command in live mode (streams output in real-time).
    internal func excecuteCommandWithSudoInLiveMode(input: String, password: String?) async -> ScriptResponse {
        guard let password = password else { return .init(error: "Password invalid", exitCode: 1) }
        
        let passwordWithNewline = password + "\n" // Add a newline to simulate pressing Enter.
        let task = Process()
        
        task.launchPath = "/usr/bin/env"
        task.arguments = ["sudo", "-S", "/bin/bash", "-c", input] // `-S` allows reading the password from stdin.
        
        let sudoIn = Pipe()
        let sudoOut = Pipe()
        task.standardOutput = sudoOut
        task.standardError = sudoOut
        task.standardInput = sudoIn
        
        task.launch() // Launch the process.
        
        // Write the password to the process.
        sudoIn.fileHandleForWriting.write(passwordWithNewline.data(using: .utf8)!)
        try? sudoIn.fileHandleForWriting.close() // Close the file handle after writing the password.
        
        // Stream the output in real-time.
        sudoOut.fileHandleForReading.readabilityHandler = { fileHandle in
            if fileHandle.availableData.count != 0 {
                print("\(String(bytes: fileHandle.availableData, encoding: .utf8) ?? "")")
            }
        }
        
        let outputData = sudoOut.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: outputData, encoding: .utf8)
        
        task.waitUntilExit() // Wait for the process to complete.
        return ScriptResponse(output: output, exitCode: task.terminationStatus)
    }
    
    /// Executes a sudo command and returns the result.
    internal func excecuteCommandWithSudo(input: String, password: String?) async -> ScriptResponse {
        print("command is \(input)")
        
        guard let password = password else { return .init(error: "Password invalid", exitCode: 1) }
        
        let passwordWithNewline = password + "\n" // Add a newline to simulate pressing Enter.
        let task = Process()
        
        task.launchPath = "/usr/bin/env"
        task.arguments = ["sudo", "-S", "/bin/bash", "-c", input] // `-S` allows reading the password from stdin.
        
        let sudoIn = Pipe()
        let sudoOut = Pipe()
        task.standardOutput = sudoOut
        task.standardError = sudoOut
        task.standardInput = sudoIn
        
        task.launch() // Launch the process.
        
        // Write the password to the process.
        sudoIn.fileHandleForWriting.write(passwordWithNewline.data(using: .utf8)!)
        try? sudoIn.fileHandleForWriting.close() // Close the file handle after writing the password.
        
        let outputData = sudoOut.fileHandleForReading.readDataToEndOfFile()
        var output = String(data: outputData, encoding: .utf8)
        print("actual output is ", output ?? "")
        if let outputTemp = output {
            output = outputTemp.deletingPrefix("Password:") // Remove the "Password:" prefix from the output.
        }
        task.waitUntilExit()
        print("status code is \(task.terminationStatus)")
        print("result is  \(output ?? "")")
        return ScriptResponse(output: output, exitCode: task.terminationStatus)
    }
    
    /// Validates if the provided password grants root privileges.
    internal func validateAccountRootPrivilege(password: String?) async -> Bool {
        let authenticatePasswordCommand = "whoami"
        let res = await self.excecuteCommandWithSudo(input: authenticatePasswordCommand, password: password)
        
        // Check if the command output is "root" and the exit code is 0.
        return res.exitCode == 0 && res.output?.trimmingCharacters(in: .whitespacesAndNewlines) == "root"
    }
}
