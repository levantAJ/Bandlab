//
//  UIViewController.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit

extension UIViewController {
    func show(error: Error, okHandler: (() -> Void)? = nil) {
        let alertVC: UIAlertController = UIAlertController(title: Constant.LocalizedString.Error, message: error.localizedDescription, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: Constant.LocalizedString.OK, style: .cancel, handler: { _ in
            okHandler?()
        })
        alertVC.addAction(okAction)
    }
}
