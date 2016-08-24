//
//  MKBlockQueue
//  Copyright © 2016 Mohsan Khan. All rights reserved.
//

//
//  https://github.com/MKGitHub/MKBlockQueue
//  http://www.xybernic.com
//  http://www.khanofsweden.com
//

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

import Foundation


    ///
    /// Observer class.
    ///
    final class MKBlockQueueObserver
    {
        fileprivate var mBlockQueueResponder:MKBlockQueueResponder!

        init(with blockQueue:MKBlockQueue)
        {
            mBlockQueueResponder = blockQueue
        }

        deinit
        {
            // disconnect reference in hold
            mBlockQueueResponder = nil
        }

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
/// The block queue class.
///
final class MKBlockQueue:MKBlockQueueResponder
{
    fileprivate var mNumOfBlocks:Int = 0
    fileprivate var mCurrentRunningBlockNumber:Int = 0
    fileprivate var mQueueIsRunning:Bool = false

    fileprivate var mBlocksArray:Array<MKBlockQueueBlockType>!
    fileprivate var mQueueCompletedBlockType:MKBlockQueueCompletedBlockType?


    // MARK:- Life Cycle


    init()
    {
        mBlocksArray = Array<MKBlockQueueBlockType>()
    }


    // MARK:- Actions


    func addBlock(_ blockQueueBlockType:MKBlockQueueBlockType)
    {
        mBlocksArray.append(blockQueueBlockType)
        mNumOfBlocks += 1
    }


    func queueCompletedBlock(_ blockQueueCompletedBlockType:MKBlockQueueCompletedBlockType)
    {
        mQueueCompletedBlockType = blockQueueCompletedBlockType
    }


    ///
    /// Run the first block with a dictionary.
    ///
    func run(with dictionary:inout Dictionary<String, Any>)
    {
        guard (mQueueIsRunning == false) else { fatalError("Queue is already running, can't start the queue again!") }

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
        guard (mBlocksArray.count > 0) else { fatalError("There are no blocks in the queue to run!") }

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

