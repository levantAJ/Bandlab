//
//  Error.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

extension NSError {
    static func error(description: String) -> Error {
        let error: NSError = NSError(domain: "com.levantAJ.Bandlab", code: 1234567, userInfo: [
            NSLocalizedDescriptionKey: description
            ])
        return error
    }
}
