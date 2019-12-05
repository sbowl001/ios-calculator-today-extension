//
//  Stack.swift
//  RPN
//
//  Created by Stephanie Bowles on 9/10/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation

struct Stack <T> : ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    
    private(set) var items: [T]
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self.items = elements
    }
    
    init(_ initialElements: [T] = [T]()){
        self.items = initialElements
    }
    
    mutating func push(_ value: T) {
        self.items.append(value)
    }
    
    mutating func pop() -> T? {
        return items.popLast()
    }
    //See the top thing on the stack without removing it
    func peek() -> T? {
        return items.last
    }
}
