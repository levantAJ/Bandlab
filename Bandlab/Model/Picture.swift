//
//  Picture.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

struct Picture: Mappable {
    var s: URL!
    var m: URL!
    var l: URL!
    var xs: URL!
    var url: URL!
    
    init() {}
    
    mutating func mapping(map: Map) {
        s = map.url("s")
        m = map.url("m")
        l = map.url("l")
        xs = map.url("xs")
        url = map.url("url")
    }
}


