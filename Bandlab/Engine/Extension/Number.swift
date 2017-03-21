//
//  Number.swift
//  Bandlab
//
//  Created by Le Tai on 3/20/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

extension Int {
    func toHoursMinutesSeconds() -> (Int, Int, Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
    
    func toDurationStringFromSeconds(showHour: Bool = false) -> String {
        let (hours, minutes, seconds) = self.toHoursMinutesSeconds()
        if showHour {
            return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        }
        return "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
}

extension FloatingPoint {
    var real: Self {
        if isNormal {
            return self
        }
        return 0
    }
    
    func toDurationStringFromSeconds(showHour: Bool = false) -> String {
        var value: Double = real as! Double
        value.round()
        let duration = Int(value).toDurationStringFromSeconds(showHour: showHour)
        return duration
    }
}
