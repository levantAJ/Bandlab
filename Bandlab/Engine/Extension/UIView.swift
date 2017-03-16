//
//  UIView.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit

extension UIView {
    func cornered(corners: UIRectCorner = .allCorners, radius: CGFloat) {
        let size: CGSize = CGSize(width: radius, height: radius)
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let mask: CAShapeLayer = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
