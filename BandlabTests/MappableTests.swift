//
//  MappableTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class MappableTests: XCTestCase {
    func testMap() {
        let json: [String: Any] = [
            "name": "Tai Le",
            "age": 26,
            "point": 8.94,
            "dob": "1991/08/06",
            "blog": "http://geek-is-stupid.github.io/",
        ]
        
        let map: Map = Map(json: json)
        XCTAssertEqual(map.string("name"), "Tai Le")
        XCTAssertEqual(map.int("age"), 26)
        XCTAssertEqual(map.double("point"), 8.94)
        XCTAssertEqual(map.date("dob", format: "yyyy/MM/dd")!.timeIntervalSince1970, "1991/08/06".date(format: "yyyy/MM/dd")!.timeIntervalSince1970)
        XCTAssertEqual(map.url("blog")!.absoluteString, "http://geek-is-stupid.github.io/")
    }
}
