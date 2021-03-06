//
//  SequenceTypeFunctionsTests.swift
//  TraverSwift
//
//  Created by adachi yuichi on 2014/12/17.
//  Copyright (c) 2014年 yad. All rights reserved.
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

class SequenceTypeFunctionsTests: XCTestCase {
    
    func testAnyFunction() {
        let seq = [1,2,3,4,5,6,7]
        let result = any (seq) { a in a > 6 }
        XCTAssert(result, "One of the elements is larger than 6")
    }
    
    func testAllFunction() {
        let seq = [1,2,3,4,5,6,7]
        let result = all (seq) { a in a > 0 }
        XCTAssert(result, "All of the elements are larger than 0")
    }

    func testIntersperseFunction() {
        XCTAssert(String(intersperse("abcde", ",")) == "a,b,c,d,e", "returns interspersed array")
    }
    
    func testSubsequenceFunction() {
        XCTAssert(subsequences([1, 2, 3]) == [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]], "returns subsequence array")
    }
    
    func testScanFunction() {
        let seq1 = SequenceOf([4, 2, 4])
        let result1 = scan(seq1, 64, /)
        XCTAssert(result1 == [64, 16, 8, 2], "returns array of reduce result")
        
        let seq2 = SequenceOf([1,2,3])
        let result2 = scan(seq2, 4) { x, y in 2 * x + y }
        XCTAssert(result2 == [4, 9, 20, 43], "returns array of reduce result")
    }
    
// TODO: With test, this causes compile error like this: Command failed due to signal: Segmentation fault: 11
//    func testFlattenFunction() {
//        let arr1 = SequenceOf([[1,2,3],[4,5,6],[7,8,9]])
//        let result1 = flatten(arr1)
//        XCTAssert(result1 == [1,2,3,4,5,6,7,8,9], "returns flattened array")
//    }
    
    func testFlatMapFunction() {
        let seq1 = SequenceOf([4, 2, 3])
        let result1 = flatMap(seq1) { elem in SequenceOf([elem, elem * 10 + elem]) }
        XCTAssert(result1 == [4, 44, 2, 22, 3, 33], "returns array of sequence's element")
    }
    
    func testGroupByFunction() {
        let seq1 = SequenceOf([1,2,3,4,5,6,7,8,9])
        let result1 = groupBy(seq1, <)
        XCTAssert(result1 == [[1, 2, 3, 4, 5, 6, 7, 8, 9]], "returns array of array for seqence grouped by second condition")
        let result2 = groupBy(seq1, >)
        XCTAssert(result2 == [[1], [2], [3], [4], [5], [6], [7], [8], [9]], "returns array of array for seqence grouped by second condition")
        let seq2 = SequenceOf([5,6,1,3,4,5,6,7,8,9,10])
        let result3 = groupBy(seq2, <)
        XCTAssert(result3 == [[5,6], [1,3,4,5,6,7,8,9,10]], "returns array of array for seqence grouped by second condition")
        let result4 = groupBy(seq2, >)
        XCTAssert(result4 == [[5],[6,1],[3],[4],[5],[6],[7],[8],[9],[10]], "returns array of array for seqence grouped by second condition")
    }
    
    func testTailFunction() {
        let seq1 = SequenceOf([1, 2, 3, 4, 5, 6])
        let result1 = tail(seq1)
        XCTAssert(result1 == [2, 3, 4, 5, 6], "get elements except first properly")
    }
    
    func testRtailFunction() {
        let seq1 = SequenceOf([1, 2, 3, 4, 5, 6])
        let result1 = rtail(seq1)
        XCTAssert(result1 == [1, 2, 3, 4, 5], "get elements except last properly")
    }
    
    func testTailsFunction() {
        let seq1 = SequenceOf([1,2,3,4])
        let result1 = tails(seq1)
        XCTAssert(result1 == [[1,2,3,4],[2,3,4],[3,4],[4],[]], "get all final segments properly")
    }
    
    func testRtailsFunction() {
        let seq1 = SequenceOf([1,2,3,4])
        let result1 = rtails(seq1)
        XCTAssert(result1 == [[],[1],[1,2],[1,2,3],[1,2,3,4]], "get all initial segments properly")
    }
    
    func testTakeWhileFunction() {
        let seq1 = SequenceOf([1,2,3,4,1,2,3,4])
        let result1 = takeWhile(seq1) { elem in elem < 3 }
        XCTAssert(result1 == [1, 2], "get the longest prefix elements properly")
        
        let seq2 = SequenceOf([1,2,3])
        let result2 = takeWhile(seq2) { elem in elem < 9 }
        XCTAssert(result2 == [1, 2, 3], "get the longest prefix elements properly")
        
        let result3 = takeWhile(seq2) { elem in elem < 0 }
        XCTAssert(result3 == [], "get the longest prefix elements properly")
    }
    
    func testDropWhileFunction() {
        let seq1 = SequenceOf([1,2,3,4,1,2,3,4])
        let result1 = dropWhile(seq1) { elem in elem < 3 }
        XCTAssert(result1 == [3,4,1,2,3,4], "get the remaining of takeWhile properly")
        
        let seq2 = SequenceOf([1,2,3])
        let result2 = dropWhile(seq2) { elem in elem < 9 }
        XCTAssert(result2 == [], "get the remaining of takeWhile properly")
        
        let result3 = dropWhile(seq2) { elem in elem < 0 }
        XCTAssert(result3 == [1, 2, 3], "get the remaining of takeWhile properly")
    }
    
    func testSpanFunction() {
        let seq1 = SequenceOf([1,2,3,4,1,2,3,4])
        let result1 = span(seq1) { elem in elem < 3 }
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