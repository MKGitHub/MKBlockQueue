//
//  MKBlockQueue
//  Copyright © 2016/2017/2018 Mohsan Khan. All rights reserved.
//

//
//  https://github.com/MKGitHub/MKBlockQueue
//  http://www.xybernic.com
//

//
//  Copyright 2016/2017/2018 Mohsan Khan
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

import Foundation


/*
    `@escaping` allows the `completionHandler` to be called after the block has finished executing i.e. at a later point.
*/


/// A block type.
typealias MKBQBlock = (_ completionHandler:@escaping MKBQBCompletionHandler, _ dictionary:inout [String:Any]) -> Void
/// A block types completion handler.
typealias MKBQBCompletionHandler = (_ dictionary:inout [String:Any]) -> Void

/// A completion block type.
typealias MKBQCompletionBlock = (_ completionHandler:@escaping MKBQCBCompletionHandler, _ dictionary:inout [String:Any]) -> Void
/// A completion block types completion handler.
typealias MKBQCBCompletionHandler = () -> Void


/**
    The main block queue class.
    We use a `class` so we don't need to mutate it like a `struct`, when passing it around.
*/
final class MKBlockQueue
{
    // MARK: Private Members

    private var mCurrentRunningBlockIndex:Int? = nil
    private var mQueueIsRunning:Bool = false
    private var mBlocksArray:[MKBQBlock]!
    private var mQueueCompletionBlock:MKBQCompletionBlock?


    // MARK:- Life Cycle


    /**
        Init a `MKBlockQueue`.

        - Parameters:
            - onCompletion: The completion block for the queue i.e. when all blocks have completed, this block is called at the end.
     */
    init(onCompletion newCompletionBlock:MKBQCompletionBlock?=nil)
    {
        log("Queue init.")

        mBlocksArray = [MKBQBlock]()
        mQueueCompletionBlock = newCompletionBlock
    }


    /*deinit
    {
        log("Queue deinit.")
    }*/


    // MARK:- Actions


    /**
        Add a block to the queue.

        - Parameters:
            - newBlock: A block type.
    */
    func addBlock(_ newBlock:@escaping MKBQBlock)
    {
        log("Queue add new block.")

        mBlocksArray.append(newBlock)
    }


    /**
        Run queue from the beginning.

        - Parameters:
            - newDictionary: A dictionary for receiving & sending data between blocks.

        - Returns: ´true´ if queue was started. ´false´ queue did not start.
    */
    @discardableResult
    func runWithDictionary(_ newDictionary:inout [String:Any]) -> Bool
    {
        guard (mBlocksArray.count > 0) else
        {
            log("There are no blocks in the queue to run!")
            return false
        }

        guard (mQueueIsRunning == false) else
        {
            log("Queue is already running!")
            return false
        }

        continueWithDictionary(&newDictionary)

        return true
    }


    // MARK:- Private


    /**
        Continue and run the next block in queue.

        - Parameters:
            - newDictionary: A dictionary for receiving & sending data between blocks.
    */
    private func continueWithDictionary(_ newDictionary:inout [String:Any])
    {
        // check if all block have been run
        // end the queue
        if (mCurrentRunningBlockIndex == (mBlocksArray.count - 1))
        {
            log("Queue has run all its blocks.")

            // if there is a completion block, call it
            if let queueCompletionBlock = mQueueCompletionBlock
            {
                queueCompletionBlock(
                {
                    [weak self] in
                    guard let self = self else { fatalError("`self` does not exist anymore!") }

                    self.mQueueIsRunning = false
                },
                &newDictionary)
            }
            else
            {
                mQueueIsRunning = false
            }

            return
        }

        //

        // start queue
        if (mCurrentRunningBlockIndex == nil)
        {
            mCurrentRunningBlockIndex = 0    // first iteration
            mQueueIsRunning = true
        }
        else
        {
            mCurrentRunningBlockIndex! += 1    // next iterations
        }

        log("Queue will run block #: \(mCurrentRunningBlockIndex!) of \(mBlocksArray.count - 1)")

        let blockAtIndex:MKBQBlock = mBlocksArray[mCurrentRunningBlockIndex!]

        blockAtIndex(
        {
            [weak self] (dictionary:inout [String:Any]) in
            guard let self = self else { fatalError("`self` does not exist anymore!") }

            self.continueWithDictionary(&dictionary)
        },
        &newDictionary)
    }


    private func log(_ newMessage:String)
    {
        // disabled by default
        //print("📦 \(newMessage)")
    }
}

