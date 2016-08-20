//
//  Moment.swift
//  timemachine
//
//  Created by David Mann on 7/16/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import Foundation

class Moment {
    var date: Date = Date()
    var dateComponents: DateComponents
    var calendar = Calendar.current
    let unitFlags = Set<Calendar.Component>([.era, .timeZone, .year, .month, .day, .hour, .minute, .second, .nanosecond])
    
    convenience init() {
        self.init(date: Date())
    }
    
    init(date: Date) {
        self.date = date
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        dateComponents = calendar.dateComponents(unitFlags, from: date)
    }
    
    func setTimeZone(_ tz: String) {
        if let timeZone = TimeZone(abbreviation: tz) {
            calendar.timeZone = timeZone
            dateComponents = calendar.dateComponents(unitFlags, from: date)
        }
    }
    
    // return components as strings for convenience
    
    func era() -> String {
        return dateComponents.era == 0 ? "BCE" : "CE"
    }
    
    func era() -> Era {
        return dateComponents.era == 0 ? .BCE : .CE
    }
    
    func year() -> String {
        return "\(dateComponents.year!)"
    }
    
    func month() -> String {
        return "\(Time.monthName[dateComponents.month! - 1])"
    }
    
    func monthNumber() -> Int {
        return dateComponents.month! - 1
    }
    
    func day() -> String {
        return "\(dateComponents.day!)"
    }
    
    func time(dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: date)
    }
    
    
    
    

}
