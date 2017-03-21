//
//  Array.swift
//  Bandlab
//
//  Created by Le Tai on 3/20/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    
    mutating func replace(_ object: Element) {
        if let index = index(of: object) {
            remove(object)
            insert(object, at: index)
        } else {
            append(object)
        }
    }
}
