//
//  ScriptRunnerNormalImp.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 12/14/1403 AP.
//

import Foundation

public class ScriptRunnerNormalImp: ScriptRunnerNormal {
    
    public func getCurrentLoggedInUsername() async -> String? {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", "stat -f%Su /dev/console"]

        let pipe = Pipe()
        task.standardOutput = pipe
        try? task.run()//launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()

        if let username = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .newlines) {
            return username.trim()
        }

        return nil
    }
    
    public func excecuteCommand(input: String) async -> ScriptResponse {
        let task = Process()
        let outputPipe = Pipe()
        
        // execute the command
        
        task.launchPath = "/usr/bin/env"
        task.arguments = ["/bin/bash", "-c", input]
        
        task.standardOutput = outputPipe
        task.launch()
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: outputData, encoding: String.Encoding.utf8) else {
            print("An error occurred while casting the command output to a string")
            return (nil, task.terminationStatus)
        }
        
        task.waitUntilExit()
        
        return (output, task.terminationStatus)
    }
    
    func runScriptWithOutSudoWithUsername(input: String, userName: String) async -> ScriptResponse{
        let task = Process()
        let stdOut = Pipe()
        let stdIn = Pipe()
        task.launchPath = "/usr/bin/sudo"
        task.standardOutput = stdOut
        task.standardError = stdOut
        task.standardInput = stdIn
        task.arguments = ["-u", userName, "/bin/bash", "-c", "-l", input]
        
        try? task.run()
        
        let outputData = stdOut.fileHandleForReading.readDataToEndOfFile()
        var output = String(data: outputData, encoding: String.Encoding.utf8)
        print("actual output is ", output ?? "")
        if let outputTemp = output {
            output = outputTemp.deletingPrefix("Password:")
        }
        task.waitUntilExit()
        print("status code is \(task.terminationStatus)")
        print("result is ", output ?? "")
        return (output?.trim(), task.terminationStatus)
    }
}
