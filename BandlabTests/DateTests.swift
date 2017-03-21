//
//  DateTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class DateTests: XCTestCase {
    func testTimeAgo() {
        var date: Date = Date()
        XCTAssertEqual(date.timeAgo, Constant.LocalizedString.JustNow)
        
        date = Date().addingTimeInterval(-10)
        XCTAssertEqual(date.timeAgo, String.localizedStringWithFormat(Constant.LocalizedString.SecondsAgo, 10))
        
        date = Date().addingTimeInterval(-59)
        XCTAssertEqual(date.timeAgo, String.localizedStringWithFormat(Constant.LocalizedString.SecondsAgo, 59))
        
        date = Date().addingTimeInterval(-60)
        XCTAssertEqual(date.timeAgo, Constant.LocalizedString.AMinuteAgo)
        
        date = Date().addingTimeInterval(-61)
        XCTAssertEqual(date.timeAgo, Constant.LocalizedString.AMinuteAgo)
        
        date = Date().addingTimeInterval(-120)
        XCTAssertEqual(date.timeAgo, String.localizedStringWithFormat(Constant.LocalizedString.MinutesAgo, 2))
        
        date = Date().addingTimeInterval(-3600)
        XCTAssertEqual(date.timeAgo, Constant.LocalizedString.AnHourAgo)
        
        date = Date().addingTimeInterval(-86400)
        XCTAssertEqual(date.timeAgo, Constant.LocalizedString.Yesterday)
        
        date = Date().addingTimeInterval(-172800)
        XCTAssertEqual(date.timeAgo, date.dateAndTime)
    }
     
    func testDateAndTime() {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy/MM/dd hh:mm"
        let date = formater.date(from: "2016/08/06 09:45")!
        XCTAssertEqual(date.dateAndTime, "08/06/2016 09:45")
    }
}
