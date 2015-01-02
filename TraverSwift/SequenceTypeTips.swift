//
//  SequenceTypeTips.swift
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


/**
A Bool indicating whether the predicate cond holds for some element in seq

:param: seq    A value of type that confirms to SequenceType protocol
:param: cond   condition for element of seq

:returns: whether cond holds for some element in seq
*/
public func any<S: SequenceType>(seq: S, cond: S.Generator.Element -> Bool) -> Bool {
    return reduce(seq, false) { acc, elem in acc || cond(elem) }
}

/**
A Bool indicating whether the predicate cond holds for all element in seq

:param: seq    A value of type that confirms to SequenceType protocol
:param: cond   condition for element of seq

:returns: whether cond holds for all element in seq
*/
public func all<S: SequenceType>(seq: S, cond: S.Generator.Element -> Bool) -> Bool {
    return reduce(seq, true) { acc, elem in acc && cond(elem) }
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

/**
Sum for Sequence type of IntegerArithmeticType Elements

:param: seq Sequence type of IntegerArithmeticType Elements

:returns: sum of elements
*/
public func sum<S: SequenceType where S.Generator.Element: IntegerArithmeticType>(seq: S) -> S.Generator.Element {
    return reduce(seq, 0 as S.Generator.Element) { acc, elem in acc + elem }
}

/**
Product for Sequence type of IntegerArithmeticType Elements

:param: seq Sequence type of IntegerArithmeticType Elements

:returns: product of elements
*/
public func product<S: SequenceType where S.Generator.Element: IntegerArithmeticType>(seq: S) -> S.Generator.Element {
    return reduce(seq, 1 as S.Generator.Element) { acc, elem in acc * elem }
}

