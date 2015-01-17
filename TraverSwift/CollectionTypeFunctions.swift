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

/**
Extract the elements after the first of a collection

:param: collection Collection type

:returns: Array of Collection Element Type
*/
public func dropFirst<C: CollectionType>(collection: C) -> [C.Generator.Element] {
    return drop(collection, collection.startIndex)
}

/**
All the elements of a collection except the last one

:param: collection Collection type

:returns: Array of Collection Element Type
*/
public func dropLast<C: CollectionType>(collection: C) -> [C.Generator.Element] {
    return take(collection, advance(collection.startIndex, distance(collection.startIndex, collection.endIndex) - 1))
}

/**
Longest prefix of collection type satisfying the condition

:param: collection  Collection type
:param: condition   condition for element

:returns: Array of Collection Element Type
*/
public func takeWhile<C: CollectionType>(collection: C, condition: C.Generator.Element -> BooleanType) -> [C.Generator.Element] {
    let index = findIndex(collection) { elem in !condition(elem).boolValue } ?? collection.endIndex
    return take(collection, index)
}

/**
Suffix of collection type remaining after takeWhile

:param: collection  Collection type
:param: condition   condition for element

:returns: Array of Collection Element Type
*/
public func dropWhile<C: CollectionType>(collection: C, condition: C.Generator.Element -> BooleanType) -> [C.Generator.Element] {
    let index = findIndex(collection) { elem in !condition(elem).boolValue } ?? collection.endIndex
    return drop(collection, index)
}

/**
Tuple where first element is longest prefix of collection type satisfying the condition and second element is the remainder of the list

:param: collection  Collection type
:param: condition   condition for element

:returns: Tuple of Array of Collection Element Type
*/
public func span<C: CollectionType>(collection: C, condition: C.Generator.Element -> BooleanType) -> ([C.Generator.Element], [C.Generator.Element]) {
    return (takeWhile(collection, condition), dropWhile(collection, condition))
}

/**
A safe casted array for type U applied to Collection Type

:param: collection Collection type (implicitly unwrapped optional)
:param: forType    U Type

:returns: optional [U]
*/
public func cast<C: CollectionType, U>(collection: C!, forType: U.Type) -> [U]? {
    let castedCollection = map(collection) { val in val as? U }
    return existsAll(castedCollection) ? castedCollection.map { val in val! } : nil
}

