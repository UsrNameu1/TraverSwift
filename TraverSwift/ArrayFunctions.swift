//
//  ArrayFunctions.swift
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
A Bool indicating the existance for some element in array

:param: array   Array of optional type

:returns: the existance for some element in array
*/
public func existsAny<T>(array: [T?]) -> Bool {
    return any(array) { elem in elem != nil }
}

/**
A Bool indicating the existance for all element in array

:param: array   Array of optional type

:returns: the existance for all element in array
*/
public func existsAll<T>(array: [T?]) -> Bool {
    return all(array) { elem in elem != nil }
}

/**
A safe casted array for type U applied to [T]!

:param: array     Array of type T(implicitly unwrapped optional)
:param: forType   U Type

:returns: optional [U]
*/
public func cast<T, U>(array: [T]!, forType: U.Type) -> [U]? {
    let safeCastedArr = array.map { val in val as? U }
    return existsAll(safeCastedArr) ? safeCastedArr.map { val in val! } : nil
}