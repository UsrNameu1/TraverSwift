//
//  CollectionTypeFunctionsTests.swift
//  TraverSwift
//
//  Created by adachi.yuichi on 2015/01/03.
//  Copyright (c) 2015年 yad. All rights reserved.
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import XCTest
import TraverSwift

class CollectionTypeFunctionsTests: XCTestCase {
    
    func testFindIndexFunction() {
        let col1 = [1,2,3,4,4,6]
        let result1 = findIndex(col1) { elem in elem > 3 }!
        XCTAssert(result1 == 3, "get index properly")
        
        let result2 = findIndex(col1) { elem in elem > 6 }
        XCTAssert(result2 == nil, "get nil when no element satisfies cond")
    }
    
    func testTakeFunction() {
        let col1 = [1,2,3,4,5,6,7]
        let result1 = take(col1, 3)
        XCTAssert(result1 == [1, 2, 3], "get prefix elements properly")
        
        let result2 = take(col1, 7)
        XCTAssert(result2 == [1, 2, 3, 4, 5, 6, 7], "get all prefix elements properly")
        
        let result3 = take(col1, 0)
        XCTAssert(result3 == [], "get empty list for initial index")
    }
    
    func testDropFunction() {
        let col1 = [1,2,3,4,5,6,7]
        let result1 = drop(col1, 3)
        XCTAssert(result1 == [4, 5, 6, 7], "get suffix elements properly")
        
        let result2 = drop(col1, 0)        
        XCTAssert(result2 == [1, 2, 3, 4, 5, 6, 7], "get all suffix elements properly")
        
        let result3 = drop(col1, 7)
        XCTAssert(result3 == [], "get empty list for last index successor")
    }
    
    func testSplitAtFunction() {
        let col1 = [1,2,3,4,5,6,7]
        let result1 = splitAt(col1, 3)
        XCTAssert(result1.0 == [1, 2, 3], "get prefix elements properly at first element of tuple")
        XCTAssert(result1.1 == [4, 5, 6,  7], "get prefix elements properly at second element of tuple")
    }
    
    func testDropFirstFunction() {
        let col1 = [1, 2, 3, 4, 5, 6]
        let result1 = dropFirst(col1)
        XCTAssert(result1 == [2, 3, 4, 5, 6], "get elements except first properly")
    }
    
    func testDropLastFunction() {
        let col1 = [1, 2, 3, 4, 5, 6]
        let result1 = dropLast(col1)
        XCTAssert(result1 == [1, 2, 3, 4, 5], "get elements except last properly")
    }

    func testTakeWhileFunction() {
        let col1 = [1,2,3,4,1,2,3,4]
        let result1 = takeWhile(col1) { elem in elem < 3 }
        XCTAssert(result1 == [1, 2], "get the longest prefix elements properly")
        
        let col2 = [1,2,3]
        let result2 = takeWhile(col2) { elem in elem < 9 }
        XCTAssert(result2 == [1, 2, 3], "get the longest prefix elements properly")
        
        let result3 = takeWhile(col2) { elem in elem < 0 }
        XCTAssert(result3 == [], "get the longest prefix elements properly")
    }
    
    func testDropWhileFunction() {
        let col1 = [1,2,3,4,1,2,3,4]
        let result1 = dropWhile(col1) { elem in elem < 3 }
        XCTAssert(result1 == [3,4,1,2,3,4], "get the remaining of takeWhile properly")
        
        let col2 = [1,2,3]
        let result2 = dropWhile(col2) { elem in elem < 9 }
        XCTAssert(result2 == [], "get the remaining of takeWhile properly")
        
        let result3 = dropWhile(col2) { elem in elem < 0 }
        XCTAssert(result3 == [1, 2, 3], "get the remaining of takeWhile properly")
    }
    
    func testSpanFunction() {
        let col1 = [1,2,3,4,1,2,3,4]
        let result1 = span(col1) { elem in elem < 3 }
        XCTAssert(result1.0 == [1, 2], "first element is the longest prefix elements")
        XCTAssert(result1.1 == [3,4,1,2,3,4], "second element is the remeining of the longest prefix elements")
    }
    
    func testCastForTypeFunction() {
        let objs: [NSObject]! = [NSString(string: "aaa"), NSNumber(int: 123), NSString(string: "ag")]
        let failResult = cast(objs, NSString.self)
        XCTAssert(failResult == nil, "Cast fail for compounded array")
        
        let strs: [NSObject]! = [NSString(string: "aaa"), NSString(), NSString(string: "ag")]
        let successResult = cast(strs, NSString.self)
        XCTAssert(successResult != nil, "Cast succeeds for pure array")
    }
}