//
//  Time.swift
//  timemachine
//
//  Created by David Mann on 6/22/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import Foundation

enum Era {
    case CE
    case BCE
}

struct DateTime {
    var era: Era = Era.CE   // CE or BCE
    var year: Int64 = Time.epochYear
    var month: Int = 0
    var day: Int = 0
    var hour: Int = 0
    var min: Int = 0
    var sec = 0
}


class Time {
    // need to use some 64 bit ints to ensure long long time periods work
    static let epochYear: Int64 = 1970
    static let secsInDay: Int64 = 24 * 60 * 60
    static let maxSec = INT64_MAX
    static let minSec = -INT64_MAX
    static let secsInMin: Int64 = 60
    static let secsInHour: Int64 = secsInMin * 60
    
    static var yearTable: [[Int]] = {
            return [
                [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
                [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            ]
    }()
    
    static var monthName: [String] = {
        return ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    }()

    static func isLeapYear(year: Int64) -> Bool {
        return leapYear(year: year) == 1
    }
    
    static func leapYear(year: Int64) -> Int {
        return ((year % 4) == 0 && ((year % 100) != 0 || (year % 400) == 0)) ? 1 : 0
    }
    
    static func yearSize(year: Int64) -> Int {
        return isLeapYear(year: year) ? 366 : 365
    }
    
    static func daysInMonth(year: Int64, month: Int) -> Int {
        return yearTable[leapYear(year: year)] [month]
    }
    
    // TODO: Handle BCE!
    static func secsToDateTime(sec: Int64) -> DateTime {
        var year = epochYear
        var dateTime = DateTime()
        let dayClock = sec % secsInDay
        var dayNumber = Int(sec / secsInDay)
        dateTime.sec = Int(dayClock % secsInMin)
        dateTime.min = Int((dayClock % 3600) / 60)
        dateTime.hour = Int(dayClock / 3600)
        while dayNumber >= yearSize(year: year) {
            dayNumber -= yearSize(year: year)
            year += 1
        }
        dateTime.year = year
        dateTime.month = 0
        while dayNumber >= yearTable[leapYear(year: year)][dateTime.month] {
            dayNumber -= yearTable[leapYear(year: year)][dateTime.month]
            dateTime.month += 1
        }
        dateTime.day = dayNumber + 1
        
        return dateTime
    }
    
    // it is easy to calculate big times if we are incrementing by small steps
    /*
     e.g. we have an initial DateTime (say the year 2,500,000).  0.5 sec user time elapses with
     a tau factor of 1000.  So we add 500 sec to initial DateTime and get new DateTime.
  */
    static func addSecsToDateTime(dateTime: DateTime, sec: Int64) -> DateTime {
        var year = dateTime.year
        var newDateTime = dateTime
        
        let clockDiff = sec % secsInDay
        var dayDiff = Int(sec / secsInDay)
            
        // stub
        return dateTime
        
        
        
    }
}

