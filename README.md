# TraverSwift

[![Build Status](https://travis-ci.org/UsrNameu1/TraverSwift.svg?branch=master)](https://travis-ci.org/UsrNameu1/TraverSwift)

A thin framework for swift's Collection effected by [Scala's Traversable](http://www.scala-lang.org/api/current/index.html#scala.collection.Traversable) & [Haskell's Data.List](http://hackage.haskell.org/package/base-4.7.0.2/docs/Data-Traversable.html)

# Table of Contents

- [Gallery](#gallery)
	- [General SequenceType](#general-sequencetype)
		- [any & all function](#any--all-function)
		- [intersperse function](#intersperse-function)
		- [subsequence function](#subsequence-function)
		- [scan function](#scan-function)
		- [flatMap function](#flatmap-function)
		- [groupBy function](#groupby-function)
	- [Equatable element SequenceType](#equatable-element-sequencetype)
		- [group function](#group-function)
		- [stripPrefix function](#stripprefix-function)
		- [distinct function](#distinct-function)
		- [equel operator](#equel-operator)
	- [Special element SequenceType](#special-element-sequencetype)
		- [sum & product function for ArithmeticType element](#sum--product-function-for-integerarithmetictype-or-floatingarithmetictypecustom-protocol-element)
		- [and & or function for BooleanType element](#and--or-function-for-booleantype-element)
	- [General CollectionType](#general-collectiontype)
		- [findIndex function](#findindex-function)
		- [take & drop & split function](#take--drop--split-function)
		- [dropFirst & dropLast function](#dropfirst--droplast-function)
		- [takeWhile & dropWhile & span function](#takewhile--dropwhile--span-function)
		- [cast function](#cast-function-for-collectiontype-wrapped-in-implicitly-unwrapped-optional)
	- [Array](#array)
		- [existsAny & existsAll function](#existsany--existsall-function-for-array-which-has-element-of-optionalt)
		- [concat function for array of array](#concat-function-for-array-of-array)
- [Documentation](#documentation)
- [Licence](#licence)

# Gallery

## General SequenceType

### any & all function

```swift
// at least one of the elements holds condition
let seq = [1,2,3,4,5,6,7]
any (seq) { a in a > 6 } // true

// all of the elements hold condition
all (seq) { a in a > 0 } // true
```

### intersperse function

```swift
// returns interspersed array
let str = "abcde"
let result = intersperse(str, ",")
result == ["a",",","b",",","c",",","d",",","e"] // true
```

### subsequence function

```swift
// returns subsequence array
let seq = [1,2,3]
let result = subsequences(seq)
result == [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]] // true
```

### scan function

```swift
// returns array of reduce result
let seq1 = SequenceOf([4, 2, 4])
scan(seq1, 64, /) == [64, 16, 8, 2] // true
scan(seq2, 4) { x, y in 2 * x + y } == [4, 9, 20, 43] // true
```

### flatMap function

```swift
// returns flattened array of sequences transformed from sequence's elements 
let seq1 = SequenceOf([4, 2, 3])
let result = flatMap(seq1) { elem in SequenceOf([elem, elem * 10 + elem]) }
result == [4,44,2,22,3,33] // true
```

### groupBy function

```swift
// returns array of array for seqence grouped by second condition
let seq1 = SequenceOf([1,2,3,4,5,6,7,8,9])
let result1 = groupBy(seq1, <)
result1 == [[1,2,3,4,5,6,7,8,9]] // true
let result2 = groupBy(seq1, >)
result2 == [[1],[2],[3],[4],[5],[6],[7],[8],[9]] // true
        
let seq2 = SequenceOf([5,6,1,3,4,5,6,7,8,9,10])
let result3 = groupBy(seq2, <)
result3 == [[5,6], [1,3,4,5,6,7,8,9,10]] // true
let result4 = groupBy(seq2, >)
result4 == [[5],[6,1],[3],[4],[5],[6],[7],[8],[9],[10]] // true
```

## Equatable element SequenceType

### group function

```swift
// returns array of array for seqence grouped by equal operator
let seq1 = SequenceOf([1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7])
let result1 = group(seq1)
result1 == [[1,1,1,1],[2,2,2,2],[3,3],[2,2,2],[5],[6],[7]] // true
```

### stripPrefix function

```swift
// returns .Some after the prefix if the sequence start with prefix given
stripPrefix("foobar", "foo")! == ["b","a","r"] // true
stripPrefix("foo", "foo")! == [] // true

// returns .None if the sequence don't start with prefix given
stripPrefix("barfoo", "foo") == nil // true
stripPrefix("barfoobaz", "foo") == nil // true
```

### distinct function

```swift
// returns array without duplicated elements
distinct([1,2,3,4,5,4,3,2,3,1,0]) == [1,2,3,4,5,0] // true
distinct("bannana") == ["b", "a", "n"] // true
```
 
### equel operator

```swift
// check whether all elements equal in the same order
let seq1 = SequenceOf([1,2,3,4,5,6])
let seq2 = SequenceOf([1,2,3,4,5,6])  
seq1 == seq2 // true
```

## Special element SequenceType

### sum & product function for IntegerArithmeticType or FloatingArithmeticType(Custom protocol) element

```swift
// sum for all elements
let seq1 = SequenceOf([1,2,3,4,5,6])
sum(seq1) == 21 // true
let seq2 = SequenceOf([1.1,2.2,3.3,4.0,5.2,6.1])
sum(seq2) == 21.9 // true

// product for all elements
let seq3 = SequenceOf([1.0,2.2,3.0,4.1,5.0,6.0])
product(seq1) == 720 // true
product(seq3) == 1.0 * 2.2 * 3.0 * 4.1 * 5.0 * 6.0 // true
```

### and & or function for BooleanType element

```swift  
// check whether all elements are true
let seq1 = SequenceOf([true, true, true, true])
and(seq1) // true

// check whether at least one element is true
let seq2 = SequenceOf([false, true, false, false])
or(seq2) // true
```

## General CollectionType

### findIndex function

```swift
// index for element of collection which satisfies a given condition first
let col1 = [1,2,3,4,4,6]
findIndex(col1) { elem in elem > 3 }! == 3 // true

// nil when no element satisfies condition
findIndex(col1) { elem in elem > 6 } == nil // true
```

### take & drop & split function

```swift
// get prefix elements indexed before given index
let col1 = [1,2,3,4,5,6,7]
take(col1, 3) == [1, 2, 3] // true
take(col1, 7) == [1, 2, 3, 4, 5, 6, 7] // true

// get suffix elements indexed after and equal to given index
drop(col1, 3) == [4, 5, 6, 7] // true
drop(col1, 0) == [1, 2, 3, 4, 5, 6, 7] // true

// get pair of take & drop function
let result1 = splitAt(col1, 3)
result1.0 == [1, 2, 3] // true
result1.1 == [4, 5, 6, 7] // true
```
    
### dropFirst & dropLast function

```swift
// get elements except first
let col1 = [1, 2, 3, 4, 5, 6]
dropFirst(col1) == [2, 3, 4, 5, 6] // true

// get elements except last
dropLast(col1) == [1, 2, 3, 4, 5] // true
```

### takeWhile & dropWhile & span function

```swift
// get the longest prefix in which elements all hold given condition
let col1 = [1,2,3,4,1,2,3,4]
takeWhile(col1) { elem in elem < 3 } == [1,2] // true

// get the remaining of takeWhile
dropWhile(col1) { elem in elem < 3 } == [3,4,1,2,3,4] // true

// get pair of takeWhile & dropWhile function
let result1 = span(col1) { elem in elem < 3 }
result1.0 == [1, 2] // true
result1.1 == [3,4,1,2,3,4] // true
```
  
### cast function (for CollectionType wrapped in Implicitly unwrapped optional)
   
```swift
// cast fail for compounded collection
let objs: [NSObject]! = [NSString(string: "aaa"), NSNumber(int: 123), NSString(string: "ag")]
cast(objs, NSString.self) == nil // true

// cast succceeds for pure collection
let strs: [NSObject]! = [NSString(string: "aaa"), NSString(), NSString(string: "ag")]
cast(strs, NSString.self) != nil // true
```

## Array

### existsAny & existsAll function (for array which has element of Optional\<T\>)

currently, function with argument of SequenceType can't be implemented with compiler crash.

```swift
// one of the elements is .Some
let arr1 = ["1e3","123","rf3","rf3"].map{ str in str.toInt() }
existsAny(arr1) // true
// all of elements are .Some
let arr2 = ["13","123","3","312"].map{ str in str.toInt() }
existsAll(arr2) // true
```

### concat function for array of array

currently, function with argument of SequenceType(flatten) can't be implemented with compiler crash.

```swift
// array of concatenation
let arr1 = [[1,2,3],[4,5,6],[7,8,9]]
concat(arr1) == [1,2,3,4,5,6,7,8,9] // true
```



# Documentation

Document generated by [jazzy](https://github.com/realm/jazzy) is [here](http://usrnameu1.github.io/TraverSwift/docs/)


# Licence

MIT
