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

//MARK: -Equatable

extension Song: Equatable {
    public static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
}


//MARK: -SongTableViewCellProtocol

extension Song: SongTableViewCellProtocol {
    internal var songId: Int {
        return id
    }
    
    internal func durationTime(completion: @escaping (String) -> Void) {
        AudioPlayer.durationFor(song: self) { (duration) in
            completion(duration.toDurationStringFromSeconds(showHour: false))
        }
    }
    
    internal var creationTime: String {
        return createdOn.timeAgo
    }
    
    internal var playingTime: String {
        return AudioPlayer.currentTimeFor(song: self).toDurationStringFromSeconds(showHour: false)
    }
    
    internal var isPlaying: Bool {
        let playing: Bool = AudioPlayer.checkIsPlaying(song: self)
        return playing
    }
    
    internal var authorName: String {
        return author.name
    }
    
    internal var authorAvatarURL: URL {
        return author.picture.s
    }
    
    internal var songName: String {
        return name
    }
    
    internal var coverImageURL: URL {
        return picture.m
    }
}
