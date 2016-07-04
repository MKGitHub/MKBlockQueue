[![Status](https://img.shields.io/badge/Status-Active doing well & alive-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![Pod](https://img.shields.io/badge/pod-1.0.0-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)

[![Platform](https://img.shields.io/badge/Platforms-macOS + iOS + tvOS + watchOS-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)
[![Swift](https://img.shields.io/badge/Swift Version-3 beta 1-blue.svg)](https://github.com/MKGitHub/MKBlockQueue)


MKBlockQueue
------
MKBlockQueue allows you to create a chain of blocks and execute them one after the other in a queue.

![Image of MKBlockQueue](https://github.com/MKGitHub/MKBlockQueue/blob/master/MKBlockQueue.png)


Example Usage
------
```swift
// create the dictionary that will be sent to the blocks
var myDictionary:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()

// create block queue
let myBlockQueue:MKBlockQueue = MKBlockQueue()

// block 1
let b1:MKBlockQueueBlockType =
{
    (blockQueueObserver:MKBlockQueueObserver, dictionary:inout Dictionary<String, AnyObject>) in

    // Do some operation here. //
 
    // Get & Set data in the `dictionary`. //

    // tell that this block is now completed
    blockQueueObserver.blockCompleted(&dictionary)
}

// block 2
let b2:MKBlockQueueBlockType =
{
    (blockQueueObserver:MKBlockQueueObserver, dictionary:inout Dictionary<String, AnyObject>) in

    // Do some operation here. //
 
    // Get & Set data in the `dictionary`. //

    // tell that this block is now completed
    blockQueueObserver.blockCompleted(&dictionary)
}

// add blocks to the queue
myBlockQueue.addBlock(b1)
myBlockQueue.addBlock(b2)

// add queue completion block for the queue
myBlockQueue.queueCompletedBlock(
{
    (dictionary:Dictionary<String, AnyObject>) in

    // The queue is now complete with all its blocks. //
})

// run queue
myBlockQueue.run(&myDictionary)
```


Notes
------
   https://github.com/MKGitHub/MKBlockQueue

   http://www.xybernic.com

   http://www.khanofsweden.com

   Copyright 2016 Mohsan Khan

   Licensed under the Apache License, Version 2.0.

