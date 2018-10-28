//
//  MKBlockQueue - Example Project
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


    private func runExample()
    {
        let blockQueue = MKBlockQueue(onCompletion:
        {
            (completionHandler:@escaping MKBQCBCompletionHandler, dictionary:inout [String:Any]) in
            print("🎉 Queue completed with dictionary: \(dictionary)")
            completionHandler()
        })

        let block1:MKBQBlock =
        {
            (completionHandler:@escaping MKBQBCompletionHandler, dictionary:inout [String:Any]) in
            dictionary["Block1Key"] = "Block1Value"
            completionHandler(&dictionary)
        }

        let block2:MKBQBlock =
        {
            (completionHandler:@escaping MKBQBCompletionHandler, dictionary:inout [String:Any]) in
            dictionary["Block2Key"] = "Block2Value"
            completionHandler(&dictionary)
        }

        let block3:MKBQBlock =
        {
            (completionHandler:@escaping MKBQBCompletionHandler, dictionary:inout [String:Any]) in
            dictionary["Block3Key"] = "Block3Value"
            completionHandler(&dictionary)
        }

        blockQueue.addBlock(block1)
        blockQueue.addBlock(block2)
        blockQueue.addBlock(block3)

        var dictionary = [String:Any](dictionaryLiteral: ("InitialKey", "InitialValue"))

        print("👉 Queue starting with dictionary: \(dictionary)")

        blockQueue.runWithDictionary(&dictionary)
    }
}

