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
        
    }
}
