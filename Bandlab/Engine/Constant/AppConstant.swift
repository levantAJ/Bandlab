//
//  AppConstant.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

//This will handle every localized string in app

import UIKit

//Group all constants in app
struct Constant {}

extension Notification.Name {
    static let AudioDidPlay = Notification.Name("com.levantAJ.Bandlab.audio.did-play")
    static let AudioDidPause = Notification.Name("com.levantAJ.Bandlab.audio.did-pause")
    static let AudioTimeDidChange = Notification.Name("com.levantAJ.Bandlab.audio.time-did-change")
    static let AudioDidReachToEnd = Notification.Name("com.levantAJ.Bandlab.audio.did-reach-to-end")
    static let AudioReadyToPlay = Notification.Name("com.levantAJ.Bandlab.audio.ready-to-play")
    static let AudioDidChange = Notification.Name("com.levantAJ.Bandlab.audio.did-change")
    static let AudioDidFail = Notification.Name("com.levantAJ.Bandlab.audio.did-fail")
    static let AudioPlaybackBufferEmpty = Notification.Name("com.levantAJ.Bandlab.audio.playback-buffer-empty")
    static let AudioPlaybackBufferFull = Notification.Name("com.levantAJ.Bandlab.audio.playback-buffer-full")
    static let AudioPlaybackLikelyToKeepUp = Notification.Name("com.levantAJ.Bandlab.audio.playback-likely-to-keep-up")
}
