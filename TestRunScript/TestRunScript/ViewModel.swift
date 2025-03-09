//
//  ViewModel.swift
//  TestRunScript
//
//  Created by Moosa Mir on 11/14/1403 AP.
//
import MSEScriptRunner

class ViewModel {
    let scriptRunner: ScriptRunner = ScriptRunnerImp(rootPassword: "", currentUserName: "")
    
    init(){
        test()
    }
    
    func test() {
        let command = "ls"
        let result = scriptRunner.excecute(input: command)
        print("Comand result is \(result.output ?? "")")
    }
}
