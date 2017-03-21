//
//  UIImageView.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit

extension UIImageView {
    func set(url: URL, completion: (() -> Void)? = nil) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            guard let data = data else { return }
            let image: UIImage? = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                completion?()
            }
        }.resume()
    }
}
