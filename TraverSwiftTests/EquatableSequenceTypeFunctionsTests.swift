//
//  EquatableSequenceTypeFunctionsTests.swift
//  TraverSwift
//
//  Created by adachi.yuichi on 2015/01/24.
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

class EquatableSequenceTypeFunctionsTests: XCTestCase {
    
    func testGroupFunction() {
        let seq1 = SequenceOf([1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7])
        let result1 = group(seq1)
        XCTAssert(result1 == [[1,1,1,1],[2,2,2,2],[3,3],[2,2,2],[5],[6],[7]] , "returns array of array for seqence grouped by equal operator")
    }
    
    func testStripPrefixFunction() {
        XCTAssert(stripPrefix("foobar", "foo")! == ["b","a","r"], "returns some string after the prefix if the sequence start with prefix given")
        XCTAssert(stripPrefix("foo", "foo")! == [], "returns empty string if the sequence equal with prefix given")
        XCTAssert(stripPrefix("barfoo", "foo") == nil, "returns .None if the sequence don't start with prefix given")
        XCTAssert(stripPrefix("barfoobaz", "foo") == nil, "returns .None if the sequence don't start with prefix given")
    }
    
    func testDistinctFunction() {
        XCTAssert(distinct([1,2,3,4,5,4,3,2,3,1,0]) == [1,2,3,4,5,0], "returns array without duplicated elements")
        XCTAssert(distinct("bannana") == ["b", "a", "n"], "returns array without duplicated elements")
    }
    
    func testEqualOperator() {
        let seq1 = SequenceOf([1,2,3,4,5,6])
        let seq2 = SequenceOf([1,2,3,4,5,6])
        let result = seq1 == seq2
        XCTAssert(result, "All elements equal in the same order")
    }
}