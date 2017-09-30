//
//  MKBlockQueue - Example Project
//  Copyright © 2016/2017 Mohsan Khan. All rights reserved.
//

//
//  https://github.com/MKGitHub/MKBlockQueue
//  http://www.xybernic.com
//  http://www.khanofsweden.com
//

//
//  Copyright 2016/2017 Mohsan Khan
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Cocoa


final class ViewController:NSViewController
{
    // MARK:- Life Cycle


    override func viewDidAppear()
    {
        super.viewDidAppear()

        runExample()
    }


    // MARK:- Example


    fileprivate func runExample()
    {
        // create the dictionary that will be sent to the blocks
        var myDictionary:Dictionary<String, Any> = Dictionary<String, Any>()
        myDictionary["InitialKey"] = "InitialValue"

        // create block queue
        let myBlockQueue:MKBlockQueue = MKBlockQueue()


        // block 1
        let b1:MKBlockQueueBlockType =
        {
            (blockQueueObserver:MKBlockQueueObserver, dictionary:inout Dictionary<String, Any>) in

            print("Block 1 started with dictionary: \(dictionary)")
            dictionary["Block1Key"] = "Block1Value"

            // tell this block is now completed
            blockQueueObserver.blockCompleted(with:&dictionary)
        }


        // block 2
        let b2:MKBlockQueueBlockType =
        {
            (blockQueueObserver:MKBlockQueueObserver, dictionary:inout Dictionary<String, Any>) in

            var copyOfDictionary:Dictionary<String, Any> = dictionary

            // test calling on main thread, async, with delay
            DispatchQueue.main.asyncAfter(deadline:(.now() + .seconds(1)), execute:
            {
                print("Block 2 started with dictionary: \(copyOfDictionary)")

                copyOfDictionary["Block2Key"] = "Block2Value"

                // tell this block is now completed
                blockQueueObserver.blockCompleted(with:&copyOfDictionary)
            })
        }


        // block 3
        let b3:MKBlockQueueBlockType =
        {
            (blockQueueObserver:MKBlockQueueObserver, dictionary:inout Dictionary<String, Any>) in

            var copyOfDictionary:Dictionary<String, Any> = dictionary

            // test calling on global background queue, async, with delay
            DispatchQueue.global(qos:.background).asyncAfter(deadline:(.now() + .seconds(1)), execute:
            {
                print("Block 3 started with dictionary: \(copyOfDictionary)")

                copyOfDictionary["Block3Key"] = "Block3Value"

                // tell this block is now completed
                blockQueueObserver.blockCompleted(with:&copyOfDictionary)
            })
        }


        // add blocks to the queue
        myBlockQueue.addBlock(b1)
        myBlockQueue.addBlock(b2)
        myBlockQueue.addBlock(b3)

        // add queue completion block for the queue
        myBlockQueue.queueCompletedBlock(
        {
            (dictionary:Dictionary<String, Any>) in
            print("Queue completed with dictionary: \(dictionary)")
        })


        // run queue
        print("Queue starting with dictionary: \(myDictionary)")
        myBlockQueue.run(with:&myDictionary)
    }
}

