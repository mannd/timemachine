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
    let formatter = DateFormatter()
    let defaultDateFormat = "Y MMM d hh:mm:ss a"
    // test
    static func UtcTimeZone() -> TimeZone! {
        return TimeZone(abbreviation: "UTC")
    }

    convenience init() {
        self.init(date: Date())
    }
    
    init(date: Date) {
        self.date = date
        calendar.timeZone = Moment.UtcTimeZone()
        dateComponents = calendar.dateComponents(unitFlags, from: date)
        formatter.dateFormat = defaultDateFormat
        formatter.timeZone = Moment.UtcTimeZone()
        
    }
    
    init(era: Era, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        calendar.timeZone = Moment.UtcTimeZone()
        dateComponents = DateComponents()
        dateComponents.era = era == .BCE ? 0 : 1
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        if let d = calendar.date(from: dateComponents) {
            date = d
        }
        else {
            date = Date()
        }
        
        
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
        return dateFormatter.string(from: date) // 
    }
    
    func formattedMoment() -> String {
        return "\(era()) \(time(dateFormatter: formatter))"
    }

}
