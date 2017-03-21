//
//  AudioPlayer.swift
//  Bandlab
//
//  Created by Le Tai on 3/20/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import AVFoundation

final class AudioPlayer: NSObject {
    static let shared: AudioPlayer = AudioPlayer()
    
    fileprivate(set) var currentSong: Song?
    fileprivate(set) var isBuffering: Bool = false
    fileprivate lazy var cache: NSCache = NSCache<NSString, AVPlayerItem>()
    fileprivate lazy var player: AVPlayer = AVPlayer()
    fileprivate var periodicTimeObserver: Any!
    
    override init() {
        super.init()
        let interval: CMTime = CMTime(seconds: 1, preferredTimescale: Int32(NSEC_PER_SEC))
        periodicTimeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] (time) in
            NotificationCenter.default.post(name: .AudioTimeDidChange, object: self?.currentSong)
        })
        
        player.addObserver(self, forKeyPath: Constant.AudioPlayer.StatusKeyPath, options: .new, context: nil)
    }
    
    deinit {
        player.removeTimeObserver(periodicTimeObserver)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let player = object as? AVPlayer,
            player == self.player,
            keyPath == Constant.AudioPlayer.StatusKeyPath {
            switch player.status {
            case .failed:
                NotificationCenter.default.post(name: .AudioDidFail, object: player.error)
            case .readyToPlay:
                NotificationCenter.default.post(name: .AudioReadyToPlay, object: currentSong)
            case .unknown:
                debugPrint("Unknown status")
            }
        }
        else if object is AVPlayerItem,
            let keyPath = keyPath {
            switch keyPath {
            case Constant.AudioPlayer.PlaybackBufferEmptyKeyPath:
                isBuffering = true
                NotificationCenter.default.post(name: .AudioPlaybackBufferEmpty, object: currentSong)
            case Constant.AudioPlayer.PlaybackBufferFullKeyPath:
                isBuffering = false
                NotificationCenter.default.post(name: .AudioPlaybackBufferFull, object: currentSong)
            case Constant.AudioPlayer.PlaybackLikelyToKeepUpKeyPath:
                isBuffering = false
                NotificationCenter.default.post(name: .AudioPlaybackLikelyToKeepUp, object: currentSong)
            default:
                debugPrint(keyPath)
            }
        }
    }
}

//MARK: -Getters & Setters

extension AudioPlayer {
    var isPlaying: Bool {
        let playing: Bool = player.isPlaying
        return playing
    }
    
    var progress: Float {
        let duration: Double = player.currentItem?.duration.seconds ?? 0
        guard duration != 0 else { return 0 }
        let currentTime: Double = player.currentTime().seconds
        return Float(currentTime / duration)
    }
    
    var currentTime: Double {
        return player.currentTime().seconds
    }
    
    func set(song: Song) {
        guard song != currentSong else { return }
        self.currentSong = song
        let key = keyFrom(song: song)
        if let playerItem = cache.object(forKey: key) {
            player.replaceCurrentItem(with: playerItem)
            addObserver(playerItem: playerItem)
        } else {
            let asset: AVURLAsset = AVURLAsset(url: song.audioLink)
            asset.loadValuesAsynchronously(forKeys: Constant.AudioPlayer.AssetLoadKeys)
            let playerItem: AVPlayerItem = AVPlayerItem(asset: asset)
            cache.setObject(playerItem, forKey: key)
            player.replaceCurrentItem(with: playerItem)
            addObserver(playerItem: playerItem)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didReachToEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        NotificationCenter.default.post(name: .AudioDidChange, object: currentSong)
        
    }
    
    func play() {
        player.play()
        NotificationCenter.default.post(name: .AudioDidPlay, object: currentSong)
    }
    
    func pause() {
        player.pause()
        NotificationCenter.default.post(name: .AudioDidPause, object: currentSong)
    }
    
    func seek(to time: CMTime) {
        player.seek(to: time)
    }
    
    class func checkIsPlaying(song: Song) -> Bool {
        guard AudioPlayer.shared.isPlaying,
            let playerItem = shared.cache.object(forKey: shared.keyFrom(song: song)),
            playerItem == shared.player.currentItem else { return false }
        return true
    }
    
    class func currentTimeFor(song: Song) -> Double {
        let key = shared.keyFrom(song: song)
        guard let playerItem = shared.cache.object(forKey: key) else { return 0 }
        return playerItem.currentTime().seconds
    }
    
    class func durationFor(song: Song, completion: @escaping (Double) -> Void) {
        DispatchQueue(label: "com.levantAJ.Bandlab.queue.adido.load-duration").async {
            let key = shared.keyFrom(song: song)
            if let playerItem = shared.cache.object(forKey: key) {
                DispatchQueue.main.async {
                    completion(playerItem.duration.seconds)
                }
            } else {
                let asset: AVURLAsset = AVURLAsset(url: song.audioLink)
                asset.loadValuesAsynchronously(forKeys: Constant.AudioPlayer.AssetLoadKeys, completionHandler: {
                    if shared.cache.object(forKey: key) == nil {
                        let playerItem: AVPlayerItem = AVPlayerItem(asset: asset)
                        shared.cache.setObject(playerItem, forKey: key)
                    }
                    DispatchQueue.main.async {
                        completion(asset.duration.seconds)
                    }
                })
            }
        }
    }
}

//MARK: -Private

extension AudioPlayer {
    fileprivate func keyFrom(song: Song) -> NSString {
        return String(song.id) as NSString
    }
    
    @objc fileprivate func didReachToEnd(_ notification: Notification) {
        player.seek(to: kCMTimeZero)
        NotificationCenter.default.post(name: .AudioDidReachToEnd, object: currentSong)
    }
    
    @objc fileprivate func readyToPlay(_ notification: Notification) {
        NotificationCenter.default.post(name: .AudioReadyToPlay, object: currentSong)
    }
    
    fileprivate func addObserver(playerItem: AVPlayerItem) {
        playerItem.addObserver(self, forKeyPath: Constant.AudioPlayer.PlaybackBufferEmptyKeyPath, options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: Constant.AudioPlayer.PlaybackBufferFullKeyPath, options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: Constant.AudioPlayer.PlaybackLikelyToKeepUpKeyPath, options: .new, context: nil)
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
    
    var url: URL? {
        let url: URL? = (currentItem?.asset as? AVURLAsset)?.url
        return url
    }
}

extension Constant {
    struct AudioPlayer {
        static let AssetLoadKeys = ["duration", "playable", "tracks"]
        static let StatusKeyPath = "status"
        static let PlaybackBufferEmptyKeyPath = "playbackBufferEmpty"
        static let PlaybackBufferFullKeyPath = "playbackBufferFull"
        static let PlaybackLikelyToKeepUpKeyPath = "playbackLikelyToKeepUp"
    }
}
