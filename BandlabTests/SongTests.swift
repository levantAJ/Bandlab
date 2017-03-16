//
//  SongTests.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import XCTest
@testable import Bandlab

final class SongTests: XCTestCase {
    func testMapping() {
        let json = jsonFrom(name: "songs")
        XCTAssertNotNil(json)
        let songs: [Song]? = Mapper<Song>().map(jsonObject: json!)
        XCTAssertNotNil(songs)
        XCTAssertEqual(songs?.count, 2)
        
        XCTAssertEqual(songs![0].id, 0)
        XCTAssertEqual(songs![0].name, "Song 1")
        XCTAssertEqual(songs![0].audioLink.absoluteString, "https://a.clyp.it/iv1xl24p.mp3")
        XCTAssertEqual(songs![0].createdOn.timeIntervalSince1970, "2016-09-23T08:15:13Z".date(format: "yyyy-MM-dd'T'HH:mm:ssZ")!.timeIntervalSince1970)
        XCTAssertEqual(songs![0].modifiedOn.timeIntervalSince1970, "2016-09-23T08:15:13Z".date(format: "yyyy-MM-dd'T'HH:mm:ssZ")!.timeIntervalSince1970)
        XCTAssertEqual(songs![0].author!.name, "Aleks")
        XCTAssertEqual(songs![0].author!.picture.s.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/360x360")
        XCTAssertEqual(songs![0].author!.picture.m.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/640x640")
        XCTAssertEqual(songs![0].author!.picture.l.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/1024x1024")
        XCTAssertEqual(songs![0].author!.picture.xs.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/100x100")
        XCTAssertEqual(songs![0].author!.picture.url.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/")
        
        XCTAssertEqual(songs![0].picture.s.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/360x360")
        XCTAssertEqual(songs![0].picture.m.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/640x640")
        XCTAssertEqual(songs![0].picture.l.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/1024x1024")
        XCTAssertEqual(songs![0].picture.xs.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/100x100")
        XCTAssertEqual(songs![0].picture.url.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803/")
        
        
        XCTAssertEqual(songs![1].id, 1)
        XCTAssertEqual(songs![1].name, "Song 2")
        XCTAssertEqual(songs![1].audioLink.absoluteString, "https://a.clyp.it/mbk0eyht.mp3")
        XCTAssertEqual(songs![1].createdOn.timeIntervalSince1970, "2016-09-23T08:12:13Z".date(format: "yyyy-MM-dd'T'HH:mm:ssZ")!.timeIntervalSince1970)
        XCTAssertEqual(songs![1].modifiedOn.timeIntervalSince1970, "2016-09-23T08:15:13Z".date(format: "yyyy-MM-dd'T'HH:mm:ssZ")!.timeIntervalSince1970)
        XCTAssertEqual(songs![1].author!.name, "Bo")
        XCTAssertEqual(songs![1].author!.picture.s.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Posts/e9a140d4-3413-408c-8a54-d875a1564bac/480x480")
        XCTAssertEqual(songs![1].author!.picture.m.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Posts/e9a140d4-3413-408c-8a54-d875a1564bac/640x640")
        XCTAssertEqual(songs![1].author!.picture.l.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Posts/e9a140d4-3413-408c-8a54-d875a1564bac/1024x1024")
        XCTAssertEqual(songs![1].author!.picture.xs.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Posts/e9a140d4-3413-408c-8a54-d875a1564bac/100x100")
        XCTAssertEqual(songs![1].author!.picture.url.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/posts/e9a140d4-3413-408c-8a54-d875a1564bac/")
        
        XCTAssertEqual(songs![1].picture.s.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Posts/e9a140d4-3413-408c-8a54-d875a1564bac/480x480")
        XCTAssertEqual(songs![1].picture.m.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Posts/e9a140d4-3413-408c-8a54-d875a1564bac/640x640")
        XCTAssertEqual(songs![1].picture.l.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Posts/e9a140d4-3413-408c-8a54-d875a1564bac/1024x1024")
        XCTAssertEqual(songs![1].picture.xs.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/Posts/e9a140d4-3413-408c-8a54-d875a1564bac/100x100")
        XCTAssertEqual(songs![1].picture.url.absoluteString, "https://bandlab-test-images.azureedge.net/v1.0/posts/e9a140d4-3413-408c-8a54-d875a1564bac/")
    }
}
