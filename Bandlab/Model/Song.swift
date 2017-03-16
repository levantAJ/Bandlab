//
//  Song.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

struct Song: Mappable {
    var id: Int!
    var name: String!
    var author: Author!
    var createdOn: Date!
    var modifiedOn: Date!
    var picture: Picture!
    var audioLink: URL!
    
    init() {}
    
    mutating func mapping(map: Map) {
        id = map.int("id")
        name = map.string("name")
        author = map.object("author")
        createdOn = map.date("createdOn", format: "yyyy-MM-dd'T'HH:mm:ssZ")
        modifiedOn = map.date("modifiedOn", format: "yyyy-MM-dd'T'HH:mm:ssZ")
        picture = map.object("picture")
        audioLink = map.url("audioLink")
    }
}
