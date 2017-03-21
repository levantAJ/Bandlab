//
//  AudioPlayer.swift
//  Bandlab
//
//  Created by Le Tai on 3/20/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import AVFoundation

final class AudioPlayer {
    static let shared: AudioPlayer = AudioPlayer()
    
    fileprivate lazy var playingSongs: [Song] = []
    fileprivate lazy var cache: NSCache = NSCache<NSString, AVPlayerItem>()
    fileprivate lazy var player: AVPlayer = AVPlayer()
    fileprivate var periodicTimeObserver: Any!
    
    init() {
        let interval: CMTime = CMTime(seconds: 1, preferredTimescale: Int32(NSEC_PER_SEC))
        periodicTimeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] (time) in
            let object: [String: Any?] = [
                "time": time.seconds,
                "currentSong": self?.currentSong,
                ]
            NotificationCenter.default.post(name: .AudioTimeDidChange, object: object)
        })
    }
    
    deinit {
        player.removeTimeObserver(periodicTimeObserver)
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: -Getters & Setters

extension AudioPlayer {
    var currentSong: Song? {
        return playingSongs.filter({ $0.audioLink == self.player.url }).first
    }
    
    var isPlaying: Bool {
        let playing: Bool = player.isPlaying
        return playing
    }
    
    func set(song: Song) {
        playingSongs.replace(song)
        let key = keyFrom(song: song)
        if let playerItem = cache.object(forKey: key) {
            player.replaceCurrentItem(with: playerItem)
        } else {
            let asset: AVURLAsset = AVURLAsset(url: song.audioLink)
            asset.loadValuesAsynchronously(forKeys: Constant.AudioPlayer.AssetLoadKeys)
            let playerItem: AVPlayerItem = AVPlayerItem(asset: asset)
            cache.setObject(playerItem, forKey: key)
            player.replaceCurrentItem(with: playerItem)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didReachToEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    func play() {
        player.play()
        NotificationCenter.default.post(name: .AudioDidPlay, object: currentSong)
    }
    
    func pause() {
        player.pause()
        NotificationCenter.default.post(name: .AudioDidPause, object: currentSong)
    }
    
    class func checkIsPlaying(song: Song) -> Bool {
        guard AudioPlayer.shared.isPlaying,
            let playerItem = shared.cache.object(forKey: shared.keyFrom(song: song)),
            playerItem == shared.player.currentItem else { return false }
        return true
    }
    
    class func currentTime(song: Song) -> Double {
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
        NotificationCenter.default.post(name: .AudioTimeDidReachToEnd, object: currentSong)
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
    }
}
