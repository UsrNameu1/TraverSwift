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
Sum for Sequence type of FloatingArithmeticType Elements

:param: sequence Sequence type of FloatingArithmeticType Elements

:returns: sum of elements
*/
public func sum<S: SequenceType where S.Generator.Element: FloatingArithmeticType>(sequence: S) -> S.Generator.Element {
    return reduce(sequence, 0.0 as S.Generator.Element) { acc, elem in acc + elem }
}

/**
Product for Sequence type of FloatingArithmeticType Elements

:param: sequence Sequence type of FloatingArithmeticType Elements

:returns: product of elements
*/
public func product<S: SequenceType where S.Generator.Element: FloatingArithmeticType>(sequence: S) -> S.Generator.Element {
    return reduce(sequence, 1.0 as S.Generator.Element) { acc, elem in acc * elem }
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
Insert element between elements of sequence

:param: sequence Sequence type
:param: element  Sequence's element type

:returns: The result of the interspersion of element between sequence elements
*/
public func intersperse<S: SequenceType>(sequence: S, element: S.Generator.Element) -> [S.Generator.Element] {
    return Array(join([element], map(sequence) { elem in [elem] } ))
}

/**
Array from intermediate to final results of reduce function

:param: sequence Sequence type
:param: initial  initial for reduce
:param: combine  combine function for reduce

:returns: Array of reduce results
*/
public func scan<S: SequenceType, U>(sequence: S, initial: U, combine: (U, S.Generator.Element) -> U) -> [U] {
    let array = Array(sequence)
    return (0...array.count).map{ index in reduce(take(array, index), initial, combine) }
}

/**
Array of flattened for sequences of sequence type element

:param: sequence Sequence type

:returns: Array of flattened results
*/
// TODO: In test, this causes compile error like this: Command failed due to signal: Segmentation fault: 11
//public func flatten<S: SequenceType, T: SequenceType where S.Generator.Element == T>(sequence: S) -> [T.Generator.Element] {
//    let array = Array(sequence)
//    return reduce(array, []) { (var acc, elem) in acc.extend(elem); return acc }
//}

/**
Array of flattened result of sequences transformed from sequence's elements

:param: sequence  Sequence type
:param: transform transform for elenemt of sequence to other sequence

:returns: Array of other sequence element
*/
public func flatMap<S: SequenceType, T: SequenceType>(sequence: S, transform: S.Generator.Element -> T) -> [T.Generator.Element] {
    return concat(Array(sequence).map{ elem in Array(transform(elem)) })
}

/**
Takes a sequence and returns a array of array such that the concatenation of the result for condition holds to the argument

:param: sequence  Sequence type
:param: condition condition for elements

:returns: Array of sequence element's array
*/
// TODO: Modify condition return value for BooleanType (which currently causes runtime error)
public func groupBy<S: SequenceType>(sequence: S, condition: (S.Generator.Element , S.Generator.Element) -> Bool) -> [[S.Generator.Element]] {
    return reduce(sequence, []) { acc, elem in
        if let lastElem = acc.last?.last {
            return condition(lastElem, elem) ? dropLast(acc) + [acc.last! + [elem]] : acc + [[elem]]
        } else {
            return [[elem]]
        }
    }
}

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
A Bool indicating the existance for some element in sequence

:param: sequence   Sequence type of element of optional

:returns: the existance for some element in array
*/
// TODO: This causes compile error like this: Command failed due to signal: Segmentation fault: 11
//public func existsAny<S: SequenceType, T where S.Generator.Element == Optional<T>>(sequence: S) -> Bool {
//    return any(sequence) { (elem: Optional<T>) in elem != nil }
//}