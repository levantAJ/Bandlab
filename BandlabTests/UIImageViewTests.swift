//
//  UIImageViewTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/21/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class UIImageViewTests: XCTestCase {
    let imageView = UIImageView()
    
    func testSetURL() {
        let url = URL(string: "https://raw.githubusercontent.com/geek-is-stupid/geek-is-stupid.github.io/master/images/post/2017-02-20-how-to-paging-uicollectionview/layout.png")!
        
        let expect = expectation(description: "test fetch image")
        
        imageView.set(url: url) { 
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            guard error == nil else { return }
            XCTAssertNotNil(self.imageView.image)
        }
    }
}
