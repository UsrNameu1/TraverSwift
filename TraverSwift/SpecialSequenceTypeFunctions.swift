//
//  SpecialSequenceTypeFunctions.swift
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
A Bool indicating the existance for some element in sequence

:param: sequence   Sequence type of element of optional

:returns: the existance for some element in array
*/
// TODO: This causes compile error like this: Command failed due to signal: Segmentation fault: 11
//public func existsAny<S: SequenceType, T where S.Generator.Element == Optional<T>>(sequence: S) -> Bool {
//    return any(sequence) { (elem: Optional<T>) in elem != nil }
//}

