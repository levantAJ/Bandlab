//
//  ErrorTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/21/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class ErrorTests: XCTestCase {
    func testError() {
        let description = "This is error message"
        let error = NSError.error(description: description)
        XCTAssertEqual(error.localizedDescription, description)
    }
}
