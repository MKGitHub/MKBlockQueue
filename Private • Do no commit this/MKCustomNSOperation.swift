//
//  MKCustomNSOperation.swift
//  NSOperationTest
//
//  Created by M K on 2016-01-26.
//  Copyright © 2016 Mohsan. All rights reserved.
//

import Foundation


typealias MKCustomNSOperationBlockType = (operation:MKCustomNSOperation) -> Void


class MKCustomNSOperation:NSOperation
{
    private var mIsAsynchronous:Bool = false
    private var mIsExecuting:Bool = false

    var pIsFinished:Bool = false
    var pBlock:MKCustomNSOperationBlockType!

    ///
    /// `true` = Run on other thread.
    /// `false` = Run synchronously on the current thread.
    ///
    /// The default value of this property is `false`.
    ///
    override var asynchronous:Bool
    {
        get {
            print("...check: asynchronous: \(mIsAsynchronous)")
            return mIsAsynchronous
        }
    }

    override var executing:Bool
    {
        get {
            print("...check: executing: \(mIsExecuting)")
            return mIsExecuting
        }
    }

    override var finished:Bool
    {
        get {
            print("...check: finished: \(pIsFinished)")
            return pIsFinished
        }
    }


    init(sync:Bool)
    {
        mIsAsynchronous = sync
        mIsExecuting = false
        pIsFinished = false

        super.init()
    }


    override func main()
    {
        mIsExecuting = true

        // operation has been cancelled before even givin a chance to start
        if (self.cancelled)
        {
            mIsExecuting = false
            pIsFinished = true
            return
        }

        pBlock(operation:self)
    }
}

