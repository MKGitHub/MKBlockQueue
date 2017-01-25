//
//  MKBlockQueue
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

import Foundation


    ///
    /// Observer class for handling the state of a block in a queue.
    ///
    final class MKBlockQueueObserver
    {
        fileprivate var mBlockQueueResponder:MKBlockQueueResponder!

        ///
        /// Init an observer.
        ///
        /// - Parameter blockQueue: The block queue.
        ///
        init(with blockQueue:MKBlockQueue)
        {
            mBlockQueueResponder = blockQueue
        }

        deinit
        {
            // disconnect reference in hold
            mBlockQueueResponder = nil
        }

        ///
        /// Tells the queue that this block has completed, and should continue to the next block in the queue.
        ///
        /// - Parameter dictionary: Dictionary for receiving and sending data between blocks.
        ///
        func blockCompleted(with dictionary:inout Dictionary<String, Any>)
        {
            mBlockQueueResponder.blockCompletionTriggered(with:&dictionary)
        }
    }


    ///
    /// Type aliases.
    ///
    typealias MKBlockQueueBlockType = (_ blockQueueObserver:MKBlockQueueObserver, _ dictionary:inout Dictionary<String, Any>) -> Void
    typealias MKBlockQueueCompletedBlockType = (_ dictionary:Dictionary<String, Any>) -> Void


    ///
    /// Responder protocol.
    ///
    fileprivate protocol MKBlockQueueResponder:class
    {
        func blockCompletionTriggered(with dictionary:inout Dictionary<String, Any>)
    }


///
/// The main block queue class.
///
final class MKBlockQueue:MKBlockQueueResponder
{
    fileprivate var mNumOfBlocks:Int = 0
    fileprivate var mCurrentRunningBlockNumber:Int = 0
    fileprivate var mQueueIsRunning:Bool = false

    fileprivate var mBlocksArray:Array<MKBlockQueueBlockType>!
    fileprivate var mQueueCompletedBlockType:MKBlockQueueCompletedBlockType?


    // MARK:- Life Cycle


    ///
    /// Init a block queue.
    ///
    init()
    {
        mBlocksArray = Array<MKBlockQueueBlockType>()
    }


    // MARK:- Actions


    ///
    /// Add a block to the queue.
    ///
    /// - Parameter blockQueueBlockType: A block type.
    ///
    func addBlock(_ blockQueueBlockType:@escaping MKBlockQueueBlockType)
    {
        mBlocksArray.append(blockQueueBlockType)
        mNumOfBlocks += 1
    }


    ///
    /// The completion block for the queue i.e. when all blocks have completed, this block is called at the end.
    ///
    /// - Parameter blockQueueCompletedBlockType: A completion block type.
    ///
    func queueCompletedBlock(_ blockQueueCompletedBlockType:@escaping MKBlockQueueCompletedBlockType)
    {
        mQueueCompletedBlockType = blockQueueCompletedBlockType
    }


    ///
    /// Run a block using a dictionary.
    ///
    /// - Parameter dictionary: A dictionary with data provided to the block.
    ///
    func run(with dictionary:inout Dictionary<String, Any>)
    {
        guard (mQueueIsRunning == false) else
        {
            print("Queue is already running, can't start the queue again!")
            return
        }

        mQueueIsRunning = true

        runNextBlock(with:&dictionary)
    }


    // MARK:- MKBlockQueueResponder


    fileprivate func blockCompletionTriggered(with dictionary:inout Dictionary<String, Any>)
    {
        runNextBlock(with:&dictionary)
    }


    // MARK:- Private


    fileprivate func runNextBlock(with dictionary:inout Dictionary<String, Any>)
    {
        guard (mBlocksArray.count > 0) else
        {
            print("There are no blocks in the queue to run!")
            return
        }

        // check if all block have been run
        if (mCurrentRunningBlockNumber == mNumOfBlocks)
        {
            mQueueIsRunning = false
            mQueueCompletedBlockType?(dictionary)
            return
        }

        mCurrentRunningBlockNumber += 1

        let blockIndex:Int = (mCurrentRunningBlockNumber - 1)
        let nextBlock:MKBlockQueueBlockType = mBlocksArray[blockIndex]

        let blockQueueObserver:MKBlockQueueObserver = MKBlockQueueObserver(with:self)

        nextBlock(blockQueueObserver, &dictionary)
    }
}

