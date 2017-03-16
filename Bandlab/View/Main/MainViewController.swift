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
    
    fileprivate var songs: [SongTableViewCellProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//MARK: -Privates

extension MainViewController {
    fileprivate func setupViews() {
        tableView.register(UINib(nibName: Constant.SongTableViewCell.ReuseIdentifier, bundle: nil), forCellReuseIdentifier: Constant.SongTableViewCell.ReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 65
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchSongs()
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
}

//MARK: -UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SongTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constant.SongTableViewCell.ReuseIdentifier, for: indexPath) as! SongTableViewCell
        cell.set(song: songs[indexPath.row])
        return cell
    }
}

//MARK: -UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
}
