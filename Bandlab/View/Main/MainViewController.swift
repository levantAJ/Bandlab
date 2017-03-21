//
//  MainViewController.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playingWrapperView: UIView!
    @IBOutlet weak var playingWrapperViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    fileprivate var songs: [SongTableViewCellModel] = []
    
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

extension MainViewController {
    fileprivate func setupViews() {
        tableView.register(UINib(nibName: Constant.SongTableViewCell.ReuseIdentifier, bundle: nil), forCellReuseIdentifier: Constant.SongTableViewCell.ReuseIdentifier)
        tableView.dataSource = self
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 65
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchSongs()
        
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidPlay(_:)), name: .AudioDidPlay, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidPause(_:)), name: .AudioDidPause, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidReachToEnd(_:)), name: .AudioTimeDidReachToEnd, object: nil)
    }
    
    fileprivate func fetchSongs() {
        SongServiceApi().retrieveSongs { [weak self] (response) in
            switch response {
            case .failure(let error):
                self?.show(error: error)
            case .success(let songs):
                self?.songs = songs.map { SongTableViewCellModel(song: $0) }
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc fileprivate func audioDidPlay(_ notification: Notification) {
        guard let song: Song = notification.object as? Song else { return}
        DispatchQueue.main.async { [weak self] in
            self?.playingWrapperView.isHidden = false
            self?.authorLabel.text = song.author.name
            self?.songNameLabel.text = song.name
            self?.playButton.setImage(.pauseItem, for: .normal)
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.playingWrapperViewBottomConstraint.constant = 0
                self?.view.layoutIfNeeded()
            })
        }
    }
    
    @objc fileprivate func audioDidPause(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.playButton.setImage(.playItem, for: .normal)
        }
    }
    
    @objc fileprivate func audioDidReachToEnd(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.playButton.setImage(.playItem, for: .normal)
        }
    }
}

//MARK: -UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SongTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constant.SongTableViewCell.ReuseIdentifier, for: indexPath) as! SongTableViewCell
        cell.set(song: songs[indexPath.row])
        cell.delegate = self
        return cell
    }
}

//MARK: -SongTableViewCellDelegate

extension MainViewController: SongTableViewCellDelegate {
    internal func songTableViewCell(_ cell: SongTableViewCell, play song: SongTableViewCellModel) {
        AudioPlayer.shared.pause()
        AudioPlayer.shared.set(song: song.song)
        AudioPlayer.shared.play()
    }
    
    internal func songTableViewCell(_ cell: SongTableViewCell, pause song: SongTableViewCellModel) {
        AudioPlayer.shared.pause()
    }
}

//MARK: -Users Interactions

extension MainViewController {
    @IBAction func playButtonTapped(button: UIButton) {
        if AudioPlayer.shared.isPlaying {
            AudioPlayer.shared.pause()
        } else {
            AudioPlayer.shared.play()
        }
    }
}
