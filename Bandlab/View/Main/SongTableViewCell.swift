//
//  SongTableViewCell.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit

protocol SongTableViewCellProtocol {
    var coverImageURL: URL { get }
    var name: String { get }
    var authorAvatarURL: URL { get }
    var authorName: String { get }
    var isPlaying: Bool { get }
    var playingTime: String { get }
    var creationTime: String { get }
}

final class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var converImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var playingTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var subAuthorLabel: UILabel!
    @IBOutlet weak var creationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
}

//MARK: -Getters & Setters

extension SongTableViewCell {
    func set(song: SongTableViewCellProtocol) {
        DispatchQueue(label: "com.levantAJ.Bandlab.queue.load-song-cell").async { [weak self] in
            let coverImageURL: URL = song.coverImageURL
            let name: String = song.name
            let authorAvatarURL: URL = song.authorAvatarURL
            let authorName: String = song.authorName
            let isPlaying: Bool = song.isPlaying
            let playingTime: String = song.playingTime
            let creationTime: String = song.creationTime
            let playImage: UIImage = isPlaying ? .pause : .play
            DispatchQueue.main.async { [weak self] in
                self?.converImageView.set(url: coverImageURL)
                self?.nameLabel.text = name
                self?.authorLabel.text = authorName
                self?.playButton.setImage(playImage, for: .normal)
                self?.playingTimeLabel.text = playingTime
                self?.authorAvatarImageView.set(url: authorAvatarURL)
                self?.creationLabel.text = creationTime
                self?.subAuthorLabel.text = authorName
            }
        }
    }
}

//MARK: -Privates

extension SongTableViewCell {
    fileprivate func setupViews() {
        authorAvatarImageView.cornered(radius: authorAvatarImageView.bounds.height/2)
    }
}

extension Constant {
    struct SongTableViewCell {
        static let ReuseIdentifier: String = "SongTableViewCell"
    }
}
