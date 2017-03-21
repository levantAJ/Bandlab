//
//  ArrayTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/20/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class ArrayTests: XCTestCase {
    func testReplace() {
        var array: [Int] =  [1, 2, 3, 4, 5]
        array.replace(2)
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
        
        array.replace(6)
        XCTAssertEqual(array, [1, 2, 3, 4, 5, 6])
    }
}
