//
//  SequenceTypeFunctions.swift
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
A Bool indicating whether the predicate condition holds for some element in sequence

:param: sequence  A value of type that confirms to SequenceType protocol
:param: condition condition for element of sequence

:returns: whether condition holds for some element in sequence
*/
public func any<S: SequenceType>(sequence: S, condition: S.Generator.Element -> BooleanType) -> Bool {
    return or(map(sequence) { elem in condition(elem).boolValue })
}

/**
A Bool indicating whether the predicate condition holds for all element in sequence

:param: sequence  A value of type that confirms to SequenceType protocol
:param: condition condition for element of sequence

:returns: whether condition holds for all element in sequence
*/
public func all<S: SequenceType>(sequence: S, condition: S.Generator.Element -> BooleanType) -> Bool {
    return and(map(sequence) { elem in condition(elem).boolValue })
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

:param: sequence Sequence type of IntegerArithmeticType Elements

:returns: sum of elements
*/
public func sum<S: SequenceType where S.Generator.Element: IntegerArithmeticType>(sequence: S) -> S.Generator.Element {
    return reduce(sequence, 0 as S.Generator.Element) { acc, elem in acc + elem }
}

/**
Product for Sequence type of IntegerArithmeticType Elements

:param: sequence Sequence type of IntegerArithmeticType Elements

:returns: product of elements
*/
public func product<S: SequenceType where S.Generator.Element: IntegerArithmeticType>(sequence: S) -> S.Generator.Element {
    return reduce(sequence, 1 as S.Generator.Element) { acc, elem in acc * elem }
}

/**
Conjunction of a BooleanType sequence

:param: sequence BooleanType sequence

:returns: whether all elements are true
*/
public func and<S: SequenceType where S.Generator.Element: BooleanType>(sequence: S) -> Bool {
    return reduce(sequence, true) { acc, elem in elem && acc }
}

/**
Disjunction of a BooleanType sequence

:param: sequence BooleanType sequence

:returns: whether at least one of the elements is true
*/
public func or<S: SequenceType where S.Generator.Element: BooleanType>(sequence: S) -> Bool {
    return reduce(sequence, false) { acc, elem in elem || acc }
}

/**
Array from intermediate to final results of reduce function

:param: sequence sequence type
:param: initial  initial for reduce
:param: combine  combine function for reduce

:returns: Array of reduce results
*/
public func scan<S: SequenceType, U>(sequence: S, initial: U, combine: (U, S.Generator.Element) -> U) -> [U] {
    let array = Array(sequence)
    return (0...array.count).map{ index in reduce(take(array, index), initial, combine) }
}