//
//  SongTableViewCellModel.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

final class SongTableViewCellModel {
    fileprivate(set) var song: Song!
    
    init(song: Song) {
        self.song = song
    }
}

//MARK: -SongTableViewCellProtocol

extension SongTableViewCellModel: SongTableViewCellProtocol {
    internal func durationTime(completion: @escaping (String) -> Void) {
        AudioPlayer.durationFor(song: song) { (duration) in
            completion(duration.toDurationStringFromSeconds(showHour: false))
        }
    }

    internal var creationTime: String {
        return song.createdOn.timeAgo
    }

    internal var playingTime: String {
        return AudioPlayer.currentTime(song: song).toDurationStringFromSeconds(showHour: false)
    }

    internal var isPlaying: Bool {
        let playing: Bool = AudioPlayer.checkIsPlaying(song: song)
        return playing
    }

    internal var authorName: String {
        return song.author.name
    }

    internal var authorAvatarURL: URL {
        return song.author.picture.s
    }

    internal var name: String {
        return song.name
    }

    internal var coverImageURL: URL {
        return song.picture.m
    }
}
