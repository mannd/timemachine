//
//  Moment.swift
//  timemachine
//
//  Created by David Mann on 7/16/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import Foundation

class Moment {
    var momentDate: Date = Date()
    var dateComponents: DateComponents
    var calendar: Calendar = Calendar.current()
    let unitFlags: Calendar.Unit = [.hour, .day, .month, .year]

//    let calendar = Calendar(calendarIdentifier: Calendar.Identifier(rawValue: NSGregorianCalendar))
    
//    let date = NSDate()
//    let unitFlags: NSCalendarUnit = [.Hour, .Day, .Month, .Year]
//    let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: date)
    
    init() {
        dateComponents = calendar.components(unitFlags, from: momentDate)
    }
    
    func setTimeZone(_ tz: String) {
        if let timeZone = TimeZone(abbreviation: tz) {
            calendar.timeZone = timeZone
            dateComponents = calendar.components(unitFlags, from: momentDate)
        }
        
    }
    
    
    
    

}
