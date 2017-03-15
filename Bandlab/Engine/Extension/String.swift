//
//  String.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

extension String {
    var ISO8601Date: Date? {
        return ISO8601DateFormatter().date(from: self)
    }
    
    func date(format: String) -> Date? {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.locale = Locale(identifier: "en_US_POSIX")
        let date: Date? = dateFormat.date(from: self)
        return date
    }
}
