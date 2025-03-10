# MSEScriptRunner

[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)  
[![Swift Version](https://img.shields.io/badge/Swift-5.5+-orange)](https://swift.org)  
[![macOS Compatible](https://img.shields.io/badge/macOS-12+-blue)](https://www.apple.com/macos)

A Swift library for executing terminal commands (normal and sudo) on macOS with support for:
- **Asynchronous execution**
- **Live output streaming**
- **Root privilege validation**
- **Username retrieval**

---

## Table of Contents
1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Quick Start](#quick-start)
5. [Usage Patterns](#usage-patterns)
6. [Security Best Practices](#security-best-practices)
7. [Download Example Script](#download-example-script)
8. [Testing](#testing)
9. [Advanced Usage](#advanced-usage)
10. [Contributing](#contributing)
11. [License](#license)

---

## Features
✅ Protocol-oriented architecture  
✅ Secure password handling patterns  
✅ Real-time command output streaming  
✅ macOS system command integration  

---

## Requirements
- **macOS**: 10.15+ (due to `Process` API usage)
- **Swift**: 5.5+
- **Xcode**: 12.0+

---

## Installation

### Using Swift Package Manager
Add this package to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/msedev3/MSEScriptRunner.git", from: "1.0.0")
]
