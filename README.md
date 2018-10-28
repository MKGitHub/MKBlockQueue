[![MadeInSweden](https://img.shields.io/badge/Made_In-Stockholm_Sweden-blue.svg)](https://en.wikipedia.org/wiki/Stockholm)
[![Status](https://img.shields.io/badge/Status-Active_and_in_development-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)

[![Version](https://img.shields.io/badge/Version-1.1-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![Carthage](https://img.shields.io/badge/carthage-1.1-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![SPM](https://img.shields.io/badge/SPM-1.1-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-🤬-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)

[![Platform](https://img.shields.io/badge/Platforms-macOS_iOS_tvOS-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![Swift](https://img.shields.io/badge/Swift_Version-4.2-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![TestCoverage](https://img.shields.io/badge/Test_Coverage-91.3％-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)


🌟 Give this repo a star and help its development grow! 🌟


MKBlockQueue
------
MKBlockQueue allows you to create and chain blocks in a queue and execute them in serial order. Compared with `NSOperation`, with MKBlockQueue you decide yourself when a block is complete and when you want the queue to continue. You can also pass data from one block to the next in the queue.

![Image of MKBlockQueue](https://github.com/MKGitHub/MKBlockQueue/blob/master/MKBlockQueue.png)

See [`ViewController.swift`](https://raw.githubusercontent.com/MKGitHub/MKBlockQueue/master/MKBlockQueue-Example-Project/ViewController.swift) for a simple example of usage.


What’s New?
------
* Version 1.1 is a major refactoring, and updates for Swift 4.2.
* Version 1.0.4 adds documentation.


Requirements
------
* Swift Version 4.2
* Xcode 10


How to Install
------
There is no framework/library distibution, I recommend that you simply add the `MKBlockQueue.swift` to your project. As this will allow you to easily find & read the MKBlockQueue API, and it will also allow MKBlockQueue to compile using your apps build settings. 

* Using Git: `git clone https://github.com/MKGitHub/MKBlockQueue.git` then add `MKBlockQueue.swift` to your Xcode project.
* Manual Way: Add `MKBlockQueue.swift` to your Xcode project.
* Using Carthage: In your Cartfile add `github "MKGitHub/MKBlockQueue" ~> 1.1` then `carthage update --no-build` then add `MKBlockQueue.swift` to your Xcode project.
* Using Swift Package Manager: swift-tools-version:4.0
* CocoaPods support has been removed! 🙌🙏🎉 Never use CocoaPods! 💀


Documentation
------
Go to the documentation [index page](http://htmlpreview.github.io/?https://raw.githubusercontent.com/MKGitHub/MKBlockQueue/master/docs/index.html).


Used In Apps
------
MKBlockQueue is used in production in the following apps/games (that I'm aware of), these apps are together used by millions of users. Please let me know if you use MKBlockQueue.

* Hoppa
* McDonald's apps
* Lånekoll


Notes
------
https://github.com/MKGitHub/MKBlockQueue

http://www.xybernic.com

Copyright 2016/2017/2018 Mohsan Khan

Licensed under the Apache License, Version 2.0.

