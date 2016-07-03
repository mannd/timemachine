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
    var sec : Double = 0.0
    
    func printDate() {
        let date = (era == Era.CE ? "CE ": "BCE ") + "\(year) \(Time.monthName[month]) \(day) \(hour):\(min):\(sec)"
        print(date)
    }
    func formatTime() -> String {
        let hourString = hour < 10 ? "0\(hour)" : "\(hour)"
        let minString = min < 10 ? "0\(min)" : "\(min)"
        let secString = sec < 10 ? "0\(Int(sec))" : "\(Int(sec))"
        return hourString + ":" + minString + ":" + secString
    }
}

func ==(lhs: DateTime, rhs: DateTime) -> Bool {
    // tolerance for comparing secs (doubles)
    let delta = 0.001
    return lhs.era == rhs.era &&
        lhs.year == rhs.year &&
        lhs.month == rhs.month &&
        lhs.day == rhs.day &&
        lhs.hour == rhs.hour &&
        lhs.min == rhs.min &&
        lhs.sec <= rhs.sec + delta &&
        lhs.sec >= rhs.sec - delta
}

func !=(lhs: DateTime, rhs: DateTime) -> Bool {
    return !(lhs == rhs)
}


class Time {
    // need to use some 64 bit ints to ensure long long time periods work
    static let epochYear: Int64 = 1970
    static let secsInDay: Int64 = 24 * 60 * 60
    static let maxSec = INT64_MAX
    static let minSec = -INT64_MAX
    static let secsInMin: Int64 = 60
    static let secsInHour: Int64 = secsInMin * 60
    static let secsIn365DayYear = 365 * secsInDay
        
    static var yearTable: [[Int]] = {
            return [
                [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
                [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            ]
    }()
    
    static var monthName: [String] = {
        return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
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
    static func secsToDateTime(sec: Double) -> DateTime {
        var year = epochYear
        var dateTime = DateTime()
        let dayClock = Int64(sec) % secsInDay
        var dayNumber = Int(Int64(sec) / secsInDay)
        dateTime.sec = Double(dayClock % secsInMin)
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
    static func addSecsToDateTime(dateTime: DateTime, sec: Double) -> DateTime {
        var newDateTime = dateTime
        var fractionalSec = sec - Double(Int(sec))
        let clockDiff = Int64(sec) % secsInDay
        var dayDiff = Int64(sec) / secsInDay
        let secDiff = Double(clockDiff % secsInMin)
        let minDiff = Int(clockDiff % 3600 / 60)
        let hourDiff = Int(clockDiff / 3600)
        newDateTime.sec += (secDiff + fractionalSec)
        fractionalSec = newDateTime.sec - Double(Int(newDateTime.sec))
        newDateTime.min += minDiff
        newDateTime.hour += hourDiff
        let minCarry = newDateTime.sec / 60
        newDateTime.sec = Double(Int64(newDateTime.sec) % 60) + fractionalSec
        newDateTime.min += Int(minCarry)
        let hourCarry = newDateTime.min / 60
        newDateTime.min %= 60
        newDateTime.hour += hourCarry
        let dayCarry = newDateTime.hour / 24
        newDateTime.hour %= 24
        dayDiff += dayCarry  // total days to add to starting date
        
        while dayDiff > 0 {
            newDateTime.day += 1
            if newDateTime.day > yearTable[leapYear(year: newDateTime.year)][newDateTime.month] {
                newDateTime.day = 1
                newDateTime.month += 1
                if newDateTime.month > 11 {
                    newDateTime.month = 0
                    newDateTime.year += 1
                }
            }
            dayDiff -= 1
        }
//        while dayDiff >= yearSize(year: newDateTime.year) {
//            dayDiff -= yearSize(year: newDateTime.year)
//            newDateTime.year += 1
//        }
//        while dayNumber >= yearTable[leapYear(year: newDateTime.year)][newDateTime.month] {
//            dayNumber -= yearTable[leapYear(year: newDateTime.year)][newDateTime.month]
//            newDateTime.month += 1
//            if newDateTime.month > 11 {
//                newDateTime.month = 0
//            }
//        }
//        newDateTime.day = dayNumber + 1
        
        return newDateTime
    }

}

