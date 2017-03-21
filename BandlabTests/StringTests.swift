//
//  StringTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/21/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class StringTests: XCTestCase {
    func testDate() {
        let string = "2016-09-23T08:12:13Z"
        let date = string.date(format: "yyyy-MM-dd'T'HH:mm:ssZ")
        XCTAssertNotNil(date)
        
        let calendar: Calendar = .current
        XCTAssertEqual(calendar.component(.year, from: date!), 2016)
        XCTAssertEqual(calendar.component(.month, from: date!), 9)
        XCTAssertEqual(calendar.component(.day, from: date!), 23)
    }
}
