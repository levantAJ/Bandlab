//
//  Author.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

struct Author: Mappable {
    var name: String!
    var picture: Picture!
    
    init() {}
    
    mutating func mapping(map: Map) {
        name = map.string("name")
        picture = map.object("picture")
    }
}
