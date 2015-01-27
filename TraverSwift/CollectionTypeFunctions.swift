//
//  CollectionTypeFunctions.swift
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

:param: collection  Collection type
:param: condition   condition for element

:returns: The first index (Optional)
*/
public func findIndex<C: CollectionType>(collection: C, condition: C.Generator.Element -> BooleanType) -> C.Index? {
    return first(filter(indices(collection)) { index in condition(collection[index]).boolValue })
}

/**
Prefix of collection from first to index element

:param: collection  Collection type
:param: index       index for element

:returns: Array of Collection Element Type
*/
public func take<C: CollectionType>(collection: C, index: C.Index) -> [C.Generator.Element] {
    return map(filter(indices(collection)) { idx in 0 < distance(idx, index) }) { idx in collection[idx] }
}

/**
Suffix of collection from index to last element

:param: collection  Collection type
:param: index       index for element

:returns: Array of Collection Element Type
*/
public func drop<C: CollectionType>(collection: C, index: C.Index) -> [C.Generator.Element] {
    return map(filter(indices(collection)) { idx in 0 <= distance(index, idx) }) { idx in collection[idx] }
}

/**
Tuple where first element is Prefix of collection from first to index element and second element is the remainder

:param: collection Collection type
:param: index      index for element

:returns: Tuple of Array of Collection Element Type
*/
public func splitAt<C: CollectionType>(collection: C, index: C.Index) -> ([C.Generator.Element], [C.Generator.Element]) {
    return (take(collection, index), drop(collection, index))
}
