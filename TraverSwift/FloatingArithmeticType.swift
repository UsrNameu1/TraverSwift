//
//  FloatingArithmeticType.swift
//  TraverSwift
//
//  Created by adachi yuichi on 2015/01/17.
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
protocol for rules of arithmetic operators in Floating values
*/
public protocol FloatingArithmeticType {
    
    /**
    Sum operator for floating type
    
    :param: lhs left hand floating type
    :param: rhs right hand flating type
    
    :returns: Sum of two floating type
    */
    func +(lhs: Self, rhs: Self) -> Self
    
    /**
    Minus operator for floating type
    
    :param: lhs left hand floating type
    :param: rhs right hand floating type
    
    :returns: Differance of two floating type
    */
    func -(lhs: Self, rhs: Self) -> Self
    
    /**
    Product operator for floating type
    
    :param: lhs left hand floating type
    :param: rhs right hand floating type
    
    :returns: Product of two floating type
    */
    func *(lhs: Self, rhs: Self) -> Self
    
    /**
    Division operator for floating type
    
    :param: lhs left hand floating type (Dividend)
    :param: rhs right hand floating type (Divisor)
    
    :returns: Quotient of two floating type
    */
    func /(lhs: Self, rhs: Self) -> Self
    
    /**
    Residue operator for floating type
    
    :param: lhs left hand floating type (Diviend)
    :param: rhs right hand floating type (Divisor)
    
    :returns: Remindor of two floating type
    */
    func %(lhs: Self, rhs: Self) -> Self
}

extension Double: FloatingArithmeticType {}

extension Float: FloatingArithmeticType {}

// This reports error like: 'Float80' is ambiguous for type lookup in this context
//extension Float80: FloatingArithmeticType {}

