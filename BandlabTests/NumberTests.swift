//
//  NumberTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/22/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class NumberTests: XCTestCase {
    func testToHoursMinutesSeconds() {
        var (hours, minutes, seconds) = 100.toHoursMinutesSeconds()
        XCTAssertEqual(hours, 0)
        XCTAssertEqual(minutes, 1)
        XCTAssertEqual(seconds, 40)
        
        (hours, minutes, seconds) = 120.toHoursMinutesSeconds()
        XCTAssertEqual(hours, 0)
        XCTAssertEqual(minutes, 2)
        XCTAssertEqual(seconds, 0)
        
        (hours, minutes, seconds) = 3600.toHoursMinutesSeconds()
        XCTAssertEqual(hours, 1)
        XCTAssertEqual(minutes, 0)
        XCTAssertEqual(seconds, 0)
        
        (hours, minutes, seconds) = 5239.toHoursMinutesSeconds()
        XCTAssertEqual(hours, 1)
        XCTAssertEqual(minutes, 27)
        XCTAssertEqual(seconds, 19)
        
        (hours, minutes, seconds) = 1245239.toHoursMinutesSeconds()
        XCTAssertEqual(hours, 345)
        XCTAssertEqual(minutes, 53)
        XCTAssertEqual(seconds, 59)
    }
    
    func testToDurationStringFromSeconds() {
        var time = 100.toDurationStringFromSeconds(showHour: false)
        XCTAssertEqual(time, "01:40")
        
        time = 100.toDurationStringFromSeconds(showHour: true)
        XCTAssertEqual(time, "00:01:40")
        
        time = 120.toDurationStringFromSeconds(showHour: false)
        XCTAssertEqual(time, "02:00")
        
        time = 3600.toDurationStringFromSeconds(showHour: true)
        XCTAssertEqual(time, "01:00:00")
    }
}
