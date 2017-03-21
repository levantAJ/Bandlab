//
//  SongTableViewCell.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit

protocol SongTableViewCellProtocol {
    var songId: Int { get }
    var coverImageURL: URL { get }
    var songName: String { get }
    var authorAvatarURL: URL { get }
    var authorName: String { get }
    var isPlaying: Bool { get }
    var playingTime: String { get }
    var creationTime: String { get }
    func durationTime(completion: @escaping (String) -> Void)
}

protocol SongTableViewCellDelegate: class {
    func songTableViewCell(_ cell: SongTableViewCell, play song: Song)
    func songTableViewCell(_ cell: SongTableViewCell, pause song: Song)
}

final class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var converImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var playingTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var subAuthorLabel: UILabel!
    @IBOutlet weak var creationLabel: UILabel!
    
    weak var delegate: SongTableViewCellDelegate?
    
    fileprivate var song: SongTableViewCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: -Getters & Setters

extension SongTableViewCell {
    func set(song: SongTableViewCellProtocol) {
        self.song = song
        DispatchQueue(label: "com.levantAJ.Bandlab.queue.load-song-cell").async { [weak self] in
            let coverImageURL: URL = song.coverImageURL
            let name: String = song.songName
            let authorAvatarURL: URL = song.authorAvatarURL
            let authorName: String = song.authorName
            let isPlaying: Bool = song.isPlaying
            let playingTime: String = song.playingTime
            let creationTime: String = song.creationTime
            let playImage: UIImage = isPlaying ? .pause : .play
            song.durationTime(completion: { [weak self] (duration) in
                self?.durationTimeLabel.text = duration
            })
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

//MARK: -Users Interactions

extension SongTableViewCell {
    @IBAction func playButtonTapped(button: UIButton) {
        if song.isPlaying {
            delegate?.songTableViewCell(self, pause: song as! Song)
        } else {
            delegate?.songTableViewCell(self, play: song as! Song)
        }
    }
}

//MARK: -Privates

extension SongTableViewCell {
    fileprivate func setupViews() {
        authorAvatarImageView.cornered(radius: authorAvatarImageView.bounds.height/2)
        
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidPlay(_:)), name: .AudioDidPlay, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidPause(_:)), name: .AudioDidPause, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioTimeDidChange(_:)), name: .AudioTimeDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidReachToEnd(_:)), name: .AudioDidReachToEnd, object: nil)
    }
    
    @objc fileprivate func audioDidPlay(_ notification: Notification) {
        guard (notification.object as? Song)?.id == song.songId else { return }
        DispatchQueue.main.async { [weak self] in
            self?.playButton.setImage(.pause, for: .normal)
        }
    }
    
    @objc fileprivate func audioDidPause(_ notification: Notification) {
        guard (notification.object as? Song)?.id == song.songId else { return }
        DispatchQueue.main.async { [weak self] in
            self?.playButton.setImage(.play, for: .normal)
        }
    }
    
    @objc fileprivate func audioTimeDidChange(_ notification: Notification) {
        guard let object = notification.object as? [String: Any?],
            let currentSong = object["currentSong"] as? Song,
            currentSong.id == song.songId else { return }
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.playingTimeLabel.text = self.song.playingTime
        }
    }
    
    @objc fileprivate func audioDidReachToEnd(_ notification: Notification) {
        guard (notification.object as? Song)?.id == song.songId else { return }
        DispatchQueue.main.async { [weak self] in
            self?.playButton.setImage(.play, for: .normal)
        }
    }
}

extension Constant {
    struct SongTableViewCell {
        static let ReuseIdentifier: String = "SongTableViewCell"
    }
}
