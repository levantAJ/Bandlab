//
//  XCTestCase.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest

extension XCTestCase {
    func jsonFrom(name: String) -> Any? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: name, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
}
