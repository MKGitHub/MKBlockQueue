//
//  MKBlockQueue
//  version 1.0.1
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

import Foundation


    ///
    /// Observer class.
    ///
    final class MKBlockQueueObserver
    {
        private var mBlockQueueResponder:MKBlockQueueResponder!

        init(blockQueue:MKBlockQueue)
        {
            mBlockQueueResponder = blockQueue
        }

        deinit
        {
            // disconnect reference in hold
            mBlockQueueResponder = nil
        }

        func blockCompleted(_ dictionary:inout Dictionary<String, AnyObject>)
        {
            mBlockQueueResponder.blockCompletionTriggered(&dictionary)
        }
    }


    ///
    /// Type aliases.
    ///
    typealias MKBlockQueueBlockType = (blockQueueObserver:MKBlockQueueObserver, dictionary:inout Dictionary<String, AnyObject>) -> Void
    typealias MKBlockQueueCompletedBlockType = (dictionary:Dictionary<String, AnyObject>) -> Void


    ///
    /// Responder protocol.
    ///
    private protocol MKBlockQueueResponder:class
    {
        func blockCompletionTriggered(_ dictionary:inout Dictionary<String, AnyObject>)
    }


///
/// The block queue class.
///
final class MKBlockQueue:MKBlockQueueResponder
{
    private var mNumOfBlocks:Int = 0
    private var mCurrentRunningBlockNumber:Int = 0
    private var mQueueIsRunning:Bool = false

    private var mBlocksArray:Array<MKBlockQueueBlockType>!
    private var mQueueCompletedBlockType:MKBlockQueueCompletedBlockType?


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
    func run(_ dictionary:inout Dictionary<String, AnyObject>)
    {
        guard (mQueueIsRunning == false) else { fatalError("Queue is already running, can't start the queue again!") }

        mQueueIsRunning = true

        runNextBlock(&dictionary)
    }


    // MARK:- MKBlockQueueResponder


    private func blockCompletionTriggered(_ dictionary:inout Dictionary<String, AnyObject>)
    {
        runNextBlock(&dictionary)
    }


    // MARK:- Private


    private func runNextBlock(_ dictionary:inout Dictionary<String, AnyObject>)
    {
        guard (mBlocksArray.count > 0) else { fatalError("There are no blocks in the queue to run!") }

        // check if all block have been run
        if (mCurrentRunningBlockNumber == mNumOfBlocks)
        {
            mQueueIsRunning = false
            mQueueCompletedBlockType?(dictionary:dictionary)
            return
        }

        mCurrentRunningBlockNumber += 1

        let blockIndex:Int = (mCurrentRunningBlockNumber - 1)
        let nextBlock:MKBlockQueueBlockType = mBlocksArray[blockIndex]

        let blockQueueObserver:MKBlockQueueObserver = MKBlockQueueObserver(blockQueue:self)

        nextBlock(blockQueueObserver:blockQueueObserver, dictionary:&dictionary)
    }
}

