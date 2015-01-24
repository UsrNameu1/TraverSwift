//
//  EquatableSequenceTypeFunctions.swift
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

/**
Takes a sequence and returns a array of array such that the concatenation of the result is equal to the argument

:param: sequence  Sequence type

:returns: Array of sequence element's array
*/
public func group<S: SequenceType where S.Generator.Element: Equatable>(sequence: S) -> [[S.Generator.Element]] {
    return groupBy(sequence) { a, b in a == b }
}

/**
Drops the given prefix from sequence

:param: sequence Sequence type
:param: prefix   Sequence type prefix

:returns: Optional.None if the sequence did not start with the prefix given , or Optional.Some the sequence after the prefix if it does
*/
public func stripPrefix<S: SequenceType where S.Generator.Element: Equatable>(sequence: S, prefix: S) -> [S.Generator.Element]? {
    return startsWith(sequence, prefix) ? drop(Array(sequence), Array(prefix).count) : nil
}

/**
Removes duplicate elements from a sequence

:param: sequence Sequence type

:returns: Array without duplicate element
*/
public func distinct<S: SequenceType where S.Generator.Element: Equatable>(sequence: S) -> [S.Generator.Element] {
    return reduce(sequence, []) { acc, elem in contains(acc, elem) ? acc : acc + [elem] }
}

/**
Equal operator for Sequence type

:param: lhs left Sequence Type
:param: rhs right Sequence Type

:returns: whether lhs & rhs contains same elements in the same order
*/
public func == <S1 : SequenceType, S2 : SequenceType where S1.Generator.Element == S2.Generator.Element, S1.Generator.Element : Equatable>(lhs: S1, rhs: S2) -> Bool {
    return equal(lhs, rhs)
}