# MSEScriptRunner

MSEScriptRunner is a Swift library that allows you to execute shell commands on macOS, including both normal and `sudo` commands. It provides a structured interface to handle command execution, capture output, and manage root privilege validation.

## Features
- Execute normal shell commands.
- Execute `sudo` commands.
- Stream live output of `sudo` commands.
- Validate root privileges.
- Get the currently logged-in username.

## Installation
### Swift Package Manager
1. Open your project in Xcode.
2. Go to **File > Swift Packages > Add Package Dependency**.
3. Enter the repository URL:
```plaintext
https://github.com/msedev3/MSEScriptRunner.git
```
4. Choose the latest version and add it to your project.

## Usage
### Import the Library
```swift
import MSEScriptRunner
```

### Initialize ScriptRunner
```swift
let runner = ScriptRunner(password: "your-sudo-password")
```

### Execute a Normal Command
```swift
Task {
    let response = await runner.excecuteCommand(input: "ls")
    if response.isSuccess {
        print("Output: \(response.output ?? "")")
    } else {
        print("Error: \(response.error ?? "")")
    }
}
```

### Execute a Sudo Command
```swift
Task {
    let response = await runner.excecuteCommandWithSudo(input: "apt-get update")
    if response.isSuccess {
        print("Output: \(response.output ?? "")")
    } else {
        print("Error: \(response.error ?? "")")
    }
}
```

### Stream Live Output of a Sudo Command
```swift
Task {
    let response = await runner.excecuteCommandWithSudoInLiveMode(input: "ping -c 4 google.com")
    if response.isSuccess {
        print("Output: \(response.output ?? "")")
    } else {
        print("Error: \(response.error ?? "")")
    }
}
```

### Validate Root Privileges
```swift
Task {
    let isRoot = await runner.validateAccountRootPrivilege()
    print(isRoot ? "Root access granted" : "Root access denied")
}
```

### Get Current Logged-in Username
```swift
Task {
    if let username = await runner.getCurrentLoggedInUsername() {
        print("Current user: \(username)")
    }
}
```

## Structure
### ScriptResponse
- `output` – Command standard output.
- `error` – Command error output.
- `exitCode` – Command exit status.
- `isSuccess` – `true` if exit code is 0.

### ScriptRunnerInterface
- `excecuteCommandWithSudoInLiveMode(input:)`
- `excecuteCommandWithSudo(input:)`
- `excecuteCommand(input:)`
- `validateAccountRootPrivilege()`
- `getCurrentLoggedInUsername()`

### ScriptRunnerNormal
- `excecuteCommand(input:)`
- `getCurrentLoggedInUsername()`

### ScriptRunnerRoot
- `excecuteCommandWithSudoInLiveMode(input:password:)`
- `excecuteCommandWithSudo(input:password:)`
- `validateAccountRootPrivilege(password:)`

## License
This project is licensed under the MIT License. See the LICENSE file for details.

