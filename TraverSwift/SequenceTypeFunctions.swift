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
Insert element between elements of sequence

:param: sequence Sequence type
:param: element  Sequence's element type

:returns: The result of the interspersion of element between sequence elements
*/
public func intersperse<S: SequenceType>(sequence: S, element: S.Generator.Element) -> [S.Generator.Element] {
    return Array(join([element], map(sequence) { elem in [elem] } ))
}

/**
Array of all subsequences from sequence

:param: sequence Sequence type

:returns: All subsequences for sequence type argument
*/
public func subsequences<S: SequenceType>(sequence: S) -> [[S.Generator.Element]] {
    return reduce(sequence, [[]]) { acc, elem in
        acc + acc.map { val in val + [elem] }
    }
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
public func groupBy<S: SequenceType>(sequence: S, condition: (S.Generator.Element , S.Generator.Element) -> Bool) -> [[S.Generator.Element]] {
    return reduce(sequence, []) { acc, elem in
        if let lastElem = acc.last?.last {
            return condition(lastElem, elem) ? rtail(acc) + [acc.last! + [elem]] : acc + [[elem]]
        } else {
            return [[elem]]
        }
    }
}// TODO: Modify condition return value for BooleanType (which currently causes runtime error)

/**
Extract the elements after the first of a sequence

:param: sequence Sequence type

:returns: Array of Sequence Element Type
*/
public func tail<S: SequenceType>(sequence: S) -> [S.Generator.Element] {
    return Array(dropFirst(Array(sequence)))
}

/**
All the elements of a sequence except the last one

:param: sequence Sequence type

:returns: Array of Sequence Element Type
*/
public func rtail<S: SequenceType>(sequence: S) -> [S.Generator.Element] {
    return Array(dropLast(Array(sequence)))
}

/**
Longest prefix of sequence type satisfying the condition

:param: sequence    Sequence type
:param: condition   condition for element

:returns: Array of Sequence Element Type
*/
public func takeWhile<S: SequenceType>(sequence: S, condition: S.Generator.Element -> BooleanType) -> [S.Generator.Element] {
    let array = Array(sequence)
    let index = findIndex(array) { elem in !condition(elem).boolValue } ?? array.endIndex
    return take(array, index)
}

/**
Suffix of sequence type remaining after takeWhile

:param: sequence    Sequence type
:param: condition   condition for element

:returns: Array of Sequence Element Type
*/
public func dropWhile<S: SequenceType>(sequence: S, condition: S.Generator.Element -> BooleanType) -> [S.Generator.Element] {
    let array = Array(sequence)
    let index = findIndex(array) { elem in !condition(elem).boolValue } ?? array.endIndex
    return drop(array, index)
}

/**
Tuple where first element is longest prefix of sequence type satisfying the condition and second element is the remainder of the list

:param: sequence    Sequence type
:param: condition   condition for element

:returns: Tuple of Array of Sequence Element Type
*/
public func span<S: SequenceType>(sequence: S, condition: S.Generator.Element -> BooleanType) -> ([S.Generator.Element], [S.Generator.Element]) {
    return (takeWhile(sequence, condition), dropWhile(sequence, condition))
}

/**
A safe casted array for type U applied to Sequence Type

:param: sequence   Sequence type (implicitly unwrapped optional)
:param: forType    U Type to cast

:returns: optional [U]
*/
public func cast<S: SequenceType, U>(sequence: S!, forType: U.Type) -> [U]? {
    let safeCastedValues = map(sequence) { val in val as? U }
    return existsAll(safeCastedValues) ? safeCastedValues.map { val in val! } : nil
}
