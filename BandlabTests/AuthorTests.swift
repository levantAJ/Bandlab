//
//  AuthorTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class AuthorTests: XCTestCase {
    func testMapping() {
        let json = jsonFrom(name: "author")
        XCTAssertNotNil(json)
        let author: Author? = Mapper<Author>().map(json: json!)
        XCTAssertNotNil(author)
        XCTAssertEqual(author!.name, "Aleks")
        XCTAssertEqual(author!.picture.s.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/360x360")
        XCTAssertEqual(author!.picture.m.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/640x640")
        XCTAssertEqual(author!.picture.l.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/1024x1024")
        XCTAssertEqual(author!.picture.xs.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/100x100")
        XCTAssertEqual(author!.picture.url.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/")
    }
}
