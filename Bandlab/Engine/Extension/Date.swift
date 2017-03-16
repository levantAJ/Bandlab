//
//  Date.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

extension Date {
    var timeAgo: String {
        let text: String
        let component = NSCalendar.current.dateComponents([.second, .minute, .hour, .day], from: self, to: Date())
        if component.day! > 1 {
            text = dateAndTime
        }
        else if component.day == 1 {
            text = Constant.LocalizedString.Yesterday
        }
        else if component.hour! > 1 {
            text = String.localizedStringWithFormat(Constant.LocalizedString.HoursAgo, component.hour!)
        }
        else if component.hour == 1 {
            text = Constant.LocalizedString.AnHourAgo
        }
        else if component.minute! > 1 {
            text = String.localizedStringWithFormat(Constant.LocalizedString.MinutesAgo, component.minute!)
        }
        else if component.minute == 1 {
            text = Constant.LocalizedString.AMinuteAgo
        }
        else if component.second! > 1 {
            text = String.localizedStringWithFormat(Constant.LocalizedString.SecondsAgo, component.second!)
        }
        else {
            text = Constant.LocalizedString.JustNow
        }
        return text
    }
    
    var dateAndTime: String {
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "MM/dd/yyyy hh:mm"
        return format.string(from: self)
    }
}
