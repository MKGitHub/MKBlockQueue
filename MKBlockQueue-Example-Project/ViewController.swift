//
//  MKBlockQueue Example Project
//
//  Created by Mohsan Khan on 2016-01-26.
//  Copyright © 2016 Mohsan Khan. All rights reserved.
//


//
//  https://github.com/MKGitHub/MKBlockQueue
//  http://www.xybernic.com
//  http://www.khanofsweden.com
//
//  Copyright 2016 Mohsan Khan
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


class ViewController:NSViewController
{
    // MARK:- Life Cycle


    override func viewDidAppear()
    {
        super.viewDidAppear()

        runExample()
    }


    // MARK:- Example


    private func runExample()
    {
        // create the dictionary that will be sent to the blocks
        var myDictionary:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        myDictionary["InitialKey"] = "InitialValue"

        // create block queue
        let myBlockQueue:MKBlockQueue = MKBlockQueue()


        // block 1
        let b1:MKBlockQueueBlockType =
        {
            (blockQueueObserver:MKBlockQueueObserver, dictionary:inout Dictionary<String, AnyObject>) in

            // test calling on main thread, after a delay
            // this has nothing to do with the blocks/queue
            DispatchQueue.main.after(when:DispatchTime.now() + 1.0, execute:
            {
                print("        Block 1 started with dictionary: \(dictionary)")
                dictionary["Block1Key"] = "Block1Value"

                // tell that this block is now completed
                blockQueueObserver.blockCompleted(&dictionary)
            })
        }

        // block 2
        let b2:MKBlockQueueBlockType =
        {
            (blockQueueObserver:MKBlockQueueObserver, dictionary:inout Dictionary<String, AnyObject>) in

            // test calling on global background queue, after a delay
            // this has nothing to do with the blocks/queue
            DispatchQueue.global(attributes:DispatchQueue.GlobalAttributes.qosBackground).after(when:DispatchTime.now() + 1.0, execute:
            {
                print("        Block 2 started with dictionary: \(dictionary)")
                dictionary["Block2Key"] = "Block2Value"

                // tell that this block is now completed
                blockQueueObserver.blockCompleted(&dictionary)
            })
        }


        // add blocks to the queue
        myBlockQueue.addBlock(b1)
        myBlockQueue.addBlock(b2)

        // add queue completion block for the queue
        myBlockQueue.queueCompletedBlock(
        {
            (dictionary:Dictionary<String, AnyObject>) in
            print("        Queue completed with dictionary: \(dictionary)")
        })


        // run queue
        print("        Queue starting with dictionary: \(myDictionary)")
        myBlockQueue.run(&myDictionary)
    }
}

