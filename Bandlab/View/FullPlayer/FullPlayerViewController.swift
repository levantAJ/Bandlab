//
//  FullPlayerViewController.swift
//  Bandlab
//
//  Created by Le Tai on 3/21/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit
import AVFoundation

final class FullPlayerViewController: UIViewController {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songAuthorLabel: UILabel!
    @IBOutlet weak var playingTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var playingSlider: UISlider!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var songs: [Song]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: -Privates

extension FullPlayerViewController {
    fileprivate func setupViews() {
        if let song = AudioPlayer.shared.currentSong {
            update(song: song)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidPlay(_:)), name: .AudioDidPlay, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidPause(_:)), name: .AudioDidPause, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioTimeDidChange(_:)), name: .AudioTimeDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidReachToEnd(_:)), name: .AudioDidReachToEnd, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidChange(_:)), name: .AudioDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidFail(_:)), name: .AudioDidFail, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioReadyToPlay(_:)), name: .AudioReadyToPlay, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlaybackBufferEmpty(_:)), name: .AudioPlaybackBufferEmpty, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlaybackBufferFull), name: .AudioPlaybackBufferFull, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlaybackLikelyToKeepUp(_:)), name: .AudioPlaybackLikelyToKeepUp, object: nil)
        
    }
    
    @objc fileprivate func audioDidPlay(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.playButton.setImage(.playerPause, for: .normal)
        }
    }
    
    @objc fileprivate func audioDidPause(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.playButton.setImage(.playerPlay, for: .normal)
        }
    }
    
    @objc fileprivate func audioTimeDidChange(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.updateCurrentTime()
        }
    }
    
    @objc fileprivate func audioDidReachToEnd(_ notification: Notification) {
        guard let song = notification.object as? Song else { return }
        DispatchQueue.main.async { [weak self] in
            self?.playButton.setImage(.playerPlay, for: .normal)
            self?.playNext(of: song)
        }
    }
    
    @objc fileprivate func audioDidChange(_ notification: Notification) {
        guard let song = notification.object as? Song else { return }
        DispatchQueue.main.async { [weak self] in
            self?.update(song: song)
        }
    }
    
    @objc fileprivate func audioDidFail(_ notification: Notification) {
        guard let error = notification.object as? Error else { return }
        DispatchQueue.main.async { [weak self] in
            self?.show(error: error)
            self?.loadingView.isHidden = true
        }
    }
    
    @objc fileprivate func audioReadyToPlay(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.isHidden = true
        }
    }
    
    @objc fileprivate func audioPlaybackBufferEmpty(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.isHidden = false
        }
    }
    
    @objc fileprivate func audioPlaybackBufferFull(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.isHidden = true
        }
    }
    
    @objc fileprivate func audioPlaybackLikelyToKeepUp(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.isHidden = true
        }
    }
    
    private func updateCurrentTime() {
        playingTimeLabel.text = AudioPlayer.shared.currentTime.toDurationStringFromSeconds()
        playingSlider.value = AudioPlayer.shared.progress
    }
    
    private func update(song: Song) {
        bgImageView.set(url: song.picture.l)
        songImageView.cornered(radius: 4)
        songImageView.set(url: song.picture.m)
        songNameLabel.text = song.name
        songAuthorLabel.text = song.author.name
        playButton.setImage(AudioPlayer.shared.isPlaying ? .playerPause: .playerPlay, for: .normal)
        nextButton.isEnabled = song != songs.last
        loadingView.isHidden = AudioPlayer.shared.isBuffering
        updateCurrentTime()
    }
    
    fileprivate func playNext(of song: Song) {
        if let index = songs.index(of: song),
            index + 1 < songs.count {
            AudioPlayer.shared.set(song: songs[index + 1])
            AudioPlayer.shared.play()
        }
    }
}

//MARK: -Users Interaction

extension FullPlayerViewController {
    @IBAction func dismissButtonTapped(button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playButtonTapped(button: UIButton) {
        if AudioPlayer.shared.isPlaying {
            AudioPlayer.shared.pause()
        } else {
            AudioPlayer.shared.play()
        }
    }
    
    @IBAction func nextButtonTapped(button: UIButton) {
        guard let song = AudioPlayer.shared.currentSong else { return }
        playNext(of: song)
    }
    
    @IBAction func previousButtonTapped(button: UIButton) {
        guard let song = AudioPlayer.shared.currentSong,
            let index = songs.index(of: song) else { return }
        if AudioPlayer.shared.currentTime < 3 && index != 0 {
            AudioPlayer.shared.set(song: songs[index - 1])
        }
        AudioPlayer.shared.seek(to: kCMTimeZero)
        AudioPlayer.shared.play()
    }
}
