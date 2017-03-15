//
//  SongTableViewCell.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit

protocol SongTableViewCellProtocol {
    var coverImageURL: URL? { get }
    var name: String { get }
    var authorAvatarURL: URL? { get }
    var authorName: String { get }
    var isPlaying: Bool { get }
    var currentPlayingTime: String { get }
    var durationTime: String { get }
    var creationTime: String { get }
}

final class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension Constant {
    struct SongTableViewCell {
        static let ReuseIdentifier: String = "SongTableViewCell"
    }
}
