[![MadeInSweden](https://img.shields.io/badge/Made_In-Stockholm_Sweden-blue.svg)](https://en.wikipedia.org/wiki/Stockholm)
[![Status](https://img.shields.io/badge/Status-Active_in_development-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)

[![Version](https://img.shields.io/badge/Version-1.0.4-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![Carthage](https://img.shields.io/badge/carthage-1.0.4-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![SPM](https://img.shields.io/badge/SPM-1.0.4-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![Pod](https://img.shields.io/badge/pod-1.0.4-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)

[![Platform](https://img.shields.io/badge/Platforms-macOS_iOS_tvOS-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![Swift](https://img.shields.io/badge/Swift_Version-3.0.1/3.1-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)


★ Give this repo a star and help its development grow! ★


MKBlockQueue
------
MKBlockQueue allows you to create a chain of blocks and execute them one after the other in a queue. Compared with `NSOperation`, with MKBlockQueue you decide yourself when a block is complete and when you want the queue to continue. You can also pass data from one block to the next.

![Image of MKBlockQueue](https://github.com/MKGitHub/MKBlockQueue/blob/master/MKBlockQueue.png)

See the `ViewController.swift` for a simple example of usage.
https://raw.githubusercontent.com/MKGitHub/MKBlockQueue/master/MKBlockQueue-Example-Project/ViewController.swift


What’s New?
------
* Version 1.0.4 adds documentation.


Requirements
------
* Swift Version 3.0.1
* ARC
* macOS 10.11 and later
* iOS 9.0 and later
* tvOS 9.0 and later


How to Install
------
There is no framework/library distibution, I recommend that you add the MKBlockQueue/Sources to your project. As this will allow you to easily find & read the MKBlockQueue API, it will also allow MKBlockQueue to compile using your apps build settings. 
* Git: run `git clone https://github.com/MKGitHub/MKBlockQueue.git` then `Drag & Drop the MKBlockQueue/Sources into your Xcode project.`
* Manual: `Drag & Drop the MKBlockQueue/Sources into your Xcode project.`
* Carthage: In your Cartfile add `github "MKGitHub/MKBlockQueue" ~> 1.0.4` then `carthage update --no-build` then `Drag & Drop the MKBlockQueue/Sources into your Xcode project.`
* Swift Package Manager (still quite meaningless): run `swift build` or `swift package generate-xcodeproj`
* CocoaPods (not recommended!): `pod 'MKBlockQueue', '~> 1.0.4'`


Documentation
------
Go to the documentation [index page](http://htmlpreview.github.io/?https://raw.githubusercontent.com/MKGitHub/MKBlockQueue/master/docs/index.html).


Used In Apps
------
MKBlockQueue is used in production in the following apps/games (known to me), these apps are together used by many millions of users every day. Please let me know if you use MKBlockQueue.

* McDonald's Sweden
* McDonald's Switzerland


Notes
------
   https://github.com/MKGitHub/MKBlockQueue

   http://www.xybernic.com

   http://www.khanofsweden.com

   Copyright 2016/2017 Mohsan Khan

   Licensed under the Apache License, Version 2.0.

