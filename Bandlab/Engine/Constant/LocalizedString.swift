//
//  LocalizedString.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

extension Constant {
    struct LocalizedString {
        static let CannotMappingObject = NSLocalizedString("Cannot mapping object!", comment: "")
        static let Unspecified = NSLocalizedString("Unspecified", comment: "")
        static let Error = NSLocalizedString("Error", comment: "")
        static let OK = NSLocalizedString("OK", comment: "")
        static let JustNow = NSLocalizedString("just now", comment: "")
        static let SecondsAgo = NSLocalizedString("%d seconds ago", comment: "")
        static let AMinuteAgo = NSLocalizedString("a minute ago", comment: "")
        static let MinutesAgo = NSLocalizedString("%d minutes ago", comment: "")
        static let AnHourAgo = NSLocalizedString("an hour ago", comment: "")
        static let HoursAgo = NSLocalizedString("%d hours ago", comment: "")
        static let Yesterday = NSLocalizedString("Yesterday", comment: "")
    }
}
