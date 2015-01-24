//
//  SpecialSequenceTypeFuncitonsTests.swift
//  TraverSwift
//
//  Created by adachi.yuichi on 2015/01/24.
//  Copyright (c) 2015年 yad. All rights reserved.
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

class SpecialSequenceTypeFunctionsTests: XCTestCase {
    
    func testSumFunction() {
        let seq1 = SequenceOf([1,2,3,4,5,6])
        let result1 = sum(seq1)
        XCTAssert(result1 == 21, "Sum of all elements can be computed properly")
        
        let seq2 = SequenceOf([1.1,2.2,3.3,4.0,5.2,6.1])
        let result2 = sum(seq2)
        XCTAssert(result2 == 21.9, "Sum of all elements can be computed properly")
    }
    
    func testProductFunction() {
        let seq1 = SequenceOf([1,2,3,4,5,6])
        let result1 = product(seq1)
        XCTAssert(result1 == 720, "Product of all elements can be computed properly")
        
        let seq2 = SequenceOf([1.0,2.2,3.0,4.1,5.0,6.0])
        let result2 = product(seq2)
        XCTAssert(result2 == 1.0 * 2.2 * 3.0 * 4.1 * 5.0 * 6.0, "Product of all elements can be computed properly")
    }
    
    func testAndFunction() {
        let seq1 = SequenceOf([false, true, true, true])
        let result1 = and(seq1)
        XCTAssert(result1 == false, "returns false if at least one of the elements is false")
        
        let seq2 = SequenceOf([true, true, true, true])
        let result2 = and(seq2)
        XCTAssert(result2 == true, "returns true if all elements are true")
    }
    
    func testOrFunction() {
        let seq1 = SequenceOf([false, true, false, false])
        let result1 = or(seq1)
        XCTAssert(result1 == true, "returns true if at least one of the elements is true")
        
        let seq2 = SequenceOf([false, false, false, false])
        let result2 = or(seq2)
        XCTAssert(result2 == false, "returns false if all elements are false")
    }
}