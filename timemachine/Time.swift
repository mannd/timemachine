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
    var era: Era    // CE or BCE
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var minute: Int
    var second: Double  // maybe Int too?
}


class Time {
    static var yearTable: [[Int]] = {
            return [
                [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
                [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            ]
    }()
    
    static var monthName: [String] = {
        return ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    }()

    static func isLeapYear(year: Int) -> Bool {
        return leapYear(year: year) == 1
    }
    
    static func leapYear(year: Int) -> Int {
        return ((year % 4) == 0 && ((year % 100) != 0 || (year % 400) == 0)) ? 1 : 0
    }
    
    static func yearSize(year: Int) -> Int {
        return isLeapYear(year: year) ? 366 : 365
    }
    
    static func daysInMonth(year: Int, month: Int) -> Int {
        return yearTable[leapYear(year: year)] [month]
    }
    
    static func secsToDateTime(sec: Double) -> DateTime {
        var dateTime = DateTime(era: Era.CE, year: 1, month: 0, day: 0, hour: 0, minute: 0, second: 0.0)
        return dateTime
    }
}

