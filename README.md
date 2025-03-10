# MSEScriptRunner

A Swift library for executing terminal commands (normal and sudo) on macOS.

## Features
✅ Execute commands with or without sudo privileges.  
✅ Stream live output for long-running commands.  
✅ Validate root access with a password.  
✅ Retrieve the current username.  

## Security Note
⚠️ **Avoid hardcoding passwords**. Use secure storage like Keychain Services.  

## Installation
Add this package to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/msedev3/MSEScriptRunner.git", from: "1.0.0")
]
