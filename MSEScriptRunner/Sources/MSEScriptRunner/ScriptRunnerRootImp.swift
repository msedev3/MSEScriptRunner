//
//  ScriptRunnerRootImp.swift
//  MSEScriptRunner
//
//  Created by Moosa Mir on 12/14/1403 AP.
//

import Foundation

public class ScriptRunnerRootImp: ScriptRunnerRoot {
    //run command with sudo and show log in middle of running
    public func excecuteCommandWithSudoInLiveMode(input: String, password: String?) async ->ScriptResponse {

        guard let password else { return ("Password invalid", 1) }
        
        let passwordWithNewline = password + "\n"
        let sudo = Process()
        
        sudo.launchPath = "/usr/bin/env"
        sudo.arguments = ["sudo", "-S", "/bin/bash", "-c", input]
        
        
        let sudoIn = Pipe()
        let sudoOut = Pipe()
        sudo.standardOutput = sudoOut
        sudo.standardError = sudoOut
        sudo.standardInput = sudoIn
        sudo.launch()
        
        // Write the password
        sudoIn.fileHandleForWriting.write(passwordWithNewline.data(using: .utf8)!)

        // Close the file handle after writing the password; avoids a
        // hang for incorrect password.
        try? sudoIn.fileHandleForWriting.close()

        
        //Show the output as it is produced
        sudoOut.fileHandleForReading.readabilityHandler = { fileHandle in
            if fileHandle.availableData.count != 0 {
                print("\(String(bytes: fileHandle.availableData, encoding: .utf8) ?? "")")
            }
        }
        
        let outputData = sudoOut.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: outputData, encoding: String.Encoding.utf8)
        
        sudo.waitUntilExit()
        return (output, sudo.terminationStatus)
    }
    
    public func excecuteCommandWithSudo(input: String, password: String?) async -> ScriptResponse {
        
        print("command is \(input)")
        
        guard let password else { return ("Password invalid", 1) }
        
        let passwordWithNewline = password + "\n"
        let sudo = Process()
        
        sudo.launchPath = "/usr/bin/env"
        sudo.arguments = ["sudo", "-S", "/bin/bash", "-c", input]
        
        
        let sudoIn = Pipe()
        let sudoOut = Pipe()
        sudo.standardOutput = sudoOut
        sudo.standardError = sudoOut
        sudo.standardInput = sudoIn
        sudo.launch()
        
        // Write the password
        sudoIn.fileHandleForWriting.write(passwordWithNewline.data(using: .utf8)!)
        
        // Close the file handle after writing the password; avoids a
        // hang for incorrect password.
        try? sudoIn.fileHandleForWriting.close()
        
        let outputData = sudoOut.fileHandleForReading.readDataToEndOfFile()
        var output = String(data: outputData, encoding: String.Encoding.utf8)
        print("actual output is ", output ?? "")
        if let outputTemp = output {
            output = outputTemp.deletingPrefix("Password:")
        }
        sudo.waitUntilExit()
        print("status code is \(sudo.terminationStatus)")
        print("result is  \(output ?? "")")
        return (output, sudo.terminationStatus)
    }
    
    public func validateAccountRootPrivilege(password: String?) async -> Bool {
        let authenticatePasswordCommand = "whoami"
        let res = await self.excecuteCommandWithSudo(input: authenticatePasswordCommand, password: password)
        
        return res.status == 0 && res.output?.trimmingCharacters(in: .whitespacesAndNewlines) == "root"
    }
}
