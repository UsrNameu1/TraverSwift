//
//  CollectionTypeTips.swift
//  TraverSwift
//
//  Created by adachi.yuichi on 2015/01/03.
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
The Index of the first element in the collection type satisfying the condition

:param: col  Collection type
:param: cond condition for element

:returns: The first index (Optional)
*/
public func findIndex<C: CollectionType>(col: C, cond: C.Generator.Element -> Bool) -> C.Index? {
    return first(filter(indices(col)) { index in cond(col[index]) })
}

/**
Prefix of collection from first to idx element

:param: col Collection type 
:param: idx index for element

:returns: Array of Collection Element Type
*/
public func take<C: CollectionType>(col: C, idx: C.Index) -> [C.Generator.Element] {
    return map(filter(indices(col)) { index in 0 < distance(index, idx) }) { index in col[index] }
}

/**
Suffix of collection from idx to last element

:param: col Collection type
:param: idx index for element

:returns: Array of Collection Element Type
*/
public func drop<C: CollectionType>(col: C, idx: C.Index) -> [C.Generator.Element] {
    return map(filter(indices(col)) { index in 0 <= distance(idx, index) }) { index in col[index] }
}

/**
Longest prefix of collection type satisfying the condition

:param: col  Collection type
:param: cond condition for element

:returns: Array of Collection Element Type
*/
public func takeWhile<C: CollectionType>(col: C, cond: C.Generator.Element -> Bool) -> [C.Generator.Element] {
    let index = findIndex(col) { elem in !cond(elem) } ?? col.endIndex
    return take(col, index)
}

/**
Suffix of collection type remaining after takeWhile

:param: col  Collection type
:param: cond condition for element

:returns: Array of Collection Element Type
*/
public func dropWhile<C: CollectionType>(col: C, cond: C.Generator.Element -> Bool) -> [C.Generator.Element] {
    let index = findIndex(col) { elem in !cond(elem) } ?? col.endIndex
    return drop(col, index)
}
