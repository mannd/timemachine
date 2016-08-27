//
//  timemachineTests.swift
//  timemachineTests
//
//  Created by David Mann on 6/8/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import XCTest
@testable import timemachine

class timemachineTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIsLeapYear() {
        XCTAssertTrue(Time.isLeapYear(year: 2016))
        XCTAssertFalse(Time.isLeapYear(year: 1000))
        XCTAssertTrue(Time.isLeapYear(year: 2008))
        XCTAssertTrue(Time.isLeapYear(year: 2000))
        XCTAssertFalse(Time.isLeapYear(year: 2001))
        XCTAssertFalse(Time.isLeapYear(year: 1902))
        XCTAssertFalse(Time.isLeapYear(year: 2200))
        XCTAssertTrue(Time.isLeapYear(year: 2400))
    }
    
    func testLeapYearDays() {
        XCTAssertTrue(Time.isLeapYear(year: 1996))
        XCTAssertTrue(Time.yearSize(year: 1996) == 366)
        XCTAssertTrue(Time.yearSize(year: 1995) == 365)
    }
    
    func testMonthDays() {
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 1) == 29))
        XCTAssertTrue((Time.daysInMonth(year: 1997, month: 1) == 28))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 0) == 31))
        XCTAssertTrue((Time.daysInMonth(year: 1997, month: 0) == 31))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 2) == 31))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 3) == 30))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 4) == 31))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 5) == 30))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 6) == 31))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 7) == 31))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 8) == 30))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 9) == 31))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 10) == 30))
        XCTAssertTrue((Time.daysInMonth(year: 1996, month: 11) == 31))
    }
    
    func testMonthNames() {
        XCTAssert(Time.monthName[0] == "Jan")
        XCTAssert(Time.monthName[1] == "Feb")
        XCTAssert(Time.monthName[2] == "Mar")
        XCTAssert(Time.monthName[3] == "Apr")
        XCTAssert(Time.monthName[4] == "May")
        XCTAssert(Time.monthName[5] == "Jun")
        XCTAssert(Time.monthName[6] == "Jul")
        XCTAssert(Time.monthName[7] == "Aug")
        XCTAssert(Time.monthName[8] == "Sep")
        XCTAssert(Time.monthName[9] == "Oct")
        XCTAssert(Time.monthName[10] == "Nov")
        XCTAssert(Time.monthName[11] == "Dec")

    }
    
    func testTime() {
        print("Max sec = \(Time.maxSec)")
        print("Min sec = \(Time.minSec)")
        XCTAssert(Time.epochYear == 1970)
        let epoch = Time.secsToDateTime(sec: 0)
        XCTAssert(epoch.year == Time.epochYear)
        XCTAssert(epoch.sec == 0)
        let dateTime = Time.secsToDateTime(sec: 365 * 3600 * 24)
        print ("dateTime.year = \(dateTime.year)")
        XCTAssert(dateTime.year == 1971)
        XCTAssert(dateTime.month == 0)
        XCTAssert(dateTime.day == 1)
        dateTime.printDate()
        // add a day
        let dateTime2 = Time.secsToDateTime(sec: 365 * 3600 * 24 + (3600 * 24))
        XCTAssert(dateTime2.day == 2)
        // below times out: figuring out dates is slow for max secs!!
        //let maxDateTime = Time.secsToDateTime(sec: Time.maxSec)
        //print("maxDateTime year = \(maxDateTime.year)")
        var epoch2 = epoch
        // test overloaded ==
        XCTAssert(epoch2 == epoch)
        epoch2.sec = 1
        XCTAssert(epoch2 != epoch)
    }
    
    // func testAddSecsToDateTime() {
    //     let time1 = Time.secsToDateTime(sec: 0) // epoch
    //     let time2 = Time.addSecsToDateTime(dateTime: time1, sec: Double(Time.secsIn365DayYear))
    //     let time2PlusYear = DateTime(era: Era.CE, year: 1971, month: 0, day: 1, hour: 0, min: 0, sec: 0)
    //     print("Test add 1 year to epoch")
    //     XCTAssert(time2 == time2PlusYear)
    //     time1.printDate()
    //     time2.printDate()
    //     time2PlusYear.printDate()
    //     let time3 = Time.secsToDateTime(sec: 35)
    //     let time4 = Time.addSecsToDateTime(dateTime: time3, sec: 35)
    //     let time5 = DateTime(era: Era.CE, year: 1970, month: 0, day: 1, hour: 0, min: 1, sec: 10)
    //     print("Test add 35 sec to 0:0:35")
    //     XCTAssert(time4 == time5)
    //     time3.printDate()
    //     time4.printDate()
    //     time5.printDate()
    //     // add 1 month to Jan 1, 1970
    //     let time6 = Time.addSecsToDateTime(dateTime: time1, sec: Double(31 * Time.secsInDay))
    //     let time7 = DateTime(era: Era.CE, year: 1970, month: 1, day: 1, hour: 0, min: 0, sec: 0)
    //     print("Test add 1 month to epoch")
    //     XCTAssert(time6 == time7)
    //     time6.printDate()
    //     time7.printDate()
    //     // Feb leap year
    //     let calendar: Calendar = Calendar.current
    //     let unitFlags = Set<Calendar.Component>([.era, .timeZone, .year, .month, .day, .hour, .minute, .second, .nanosecond])
    //     let dc8 = DateComponents(calendar: calendar, timeZone: nil, era: 1, year: 1980, month: 2, day: 1, hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
    //     print("dc8 year = \(dc8.year)")
    //     let dc8Date: Date = dc8.date!
    //     let newDate = dc8Date.addingTimeInterval(Double(28 * Time.secsInDay))
    //     let dc9 = calendar.dateComponents(unitFlags, from: newDate)
    //     let dc10 = DateComponents(calendar: calendar, timeZone: nil, era: 1, year: 1980, month: 2, day: 29, hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
    //     XCTAssert(dc9.day == dc10.day)
    //     print(dc9.month)
    //     print(dc9.day)
    //     print(dc9.date)
    //     print(dc10.date)
        
    //     let time8 = DateTime(era: Era.CE, year: 1980, month: 1, day: 1, hour: 0, min: 0, sec: 0)
    //     let time9 = Time.addSecsToDateTime(dateTime: time8, sec: Double(28 * Time.secsInDay))
    //     let time10 = DateTime(era: Era.CE, year: 1980, month: 1, day: 29, hour: 0, min: 0, sec: 0)
    //     print("Test add 28 days to Feb 1 1980 (leap year)")
    //     time8.printDate()
    //     time9.printDate()
    //     time10.printDate()
    //     XCTAssert(time9 == time10)
    //     // Feb no leap year
    //     let time11 = DateTime(era: Era.CE, year: 1981, month: 1, day: 1, hour: 0, min: 0, sec: 0)
    //     let time12 = Time.addSecsToDateTime(dateTime: time11, sec: Double(28 * Time.secsInDay))
    //     let time13 = DateTime(era: Era.CE, year: 1981, month: 2, day: 1, hour: 0, min: 0, sec: 0)
    //     print("Test add 28 days to Feb 1 1981 (not a leap year)")
    //     XCTAssert(time12 == time13)
    //     time11.printDate()
    //     time12.printDate()
    //     time13.printDate()
    //     // Arbitrary long date-time jump
    //     let time14 = DateTime(era: Era.CE, year: 2017, month: 11, day: 13, hour: 13, min: 23, sec: 45)
    //     let time15 = Time.addSecsToDateTime(dateTime: time14, sec: 165335743)
    //     let time16 = DateTime(era: Era.CE, year: 2023, month: 2, day: 11, hour: 3, min: 59, sec: 28)
    //     print("Test add long whole number of secs to Dec 13 2017 13:23:45")
    //     time14.printDate()
    //     time15.printDate()
    //     time16.printDate()
    //     XCTAssert(time15 == time16)
    //     // test fractional secs
    //     let time17 = DateTime(era: Era.CE, year: 1970, month: 0, day: 1, hour: 0, min: 0, sec: 2.4)
    //     let time18 = Time.addSecsToDateTime(dateTime: time17, sec: 1.8)
    //     let time19 = DateTime(era: Era.CE, year: 1970, month: 0, day: 1, hour: 0, min: 0, sec: 4.2)
    //     // test add fractional secs
    //     time17.printDate()
    //     time18.printDate()
    //     time19.printDate()
    //     XCTAssert(time18 == time19)
    //     let time20 = Time.addSecsToDateTime(dateTime: time14, sec: 0.755)
    //     let time21 = Time.addSecsToDateTime(dateTime: time20, sec: 165335743.901)
    //     let time22 = Time.addSecsToDateTime(dateTime: time16, sec: 1.656)
    //     print("Test add long fractional secs to Dec 13 2017 13:23:45")
    //     XCTAssert(time21 == time22)
    //     time20.printDate()
    //     time21.printDate()
    //     time22.printDate()
    // }
    
    func testPositiveSecsToDateTime() {
        let yearAfterEpoch = Time.secsToDateTime(sec: 365 * 24 * 3600)
        XCTAssert(yearAfterEpoch.year == 1971)
        XCTAssert(yearAfterEpoch.month == 0)
        XCTAssert(yearAfterEpoch.day == 1)
        XCTAssert(yearAfterEpoch.hour == 0)
        XCTAssert(yearAfterEpoch.min == 0)
        XCTAssert(yearAfterEpoch.sec == 0)
        // Feb 19 1972 13:29:11
        let arbitrarySecs = TimeInterval(2 * (365 * 24 * 3600) + (50 * 24 * 3600) +
            (13 * 3600) + (29 * 60) + 11)
        let arbitraryIntervalAfterEpoch = Time.secsToDateTime(sec: arbitrarySecs)
        arbitraryIntervalAfterEpoch.printDate()
        XCTAssert(arbitraryIntervalAfterEpoch.year == 1972)
        XCTAssert(arbitraryIntervalAfterEpoch.month == 1)
        XCTAssert(arbitraryIntervalAfterEpoch.day == 20)
        XCTAssert(arbitraryIntervalAfterEpoch.hour == 13)
        XCTAssert(arbitraryIntervalAfterEpoch.min == 29)
        XCTAssert(arbitraryIntervalAfterEpoch.sec == 11)
        let anotherArbitrarySecs = TimeInterval(8 * (365 * 24 * 3600) + 200 * (24 * 3600) + 122)
        // Jul 18 1978 0:02:02 -- period includes leap years
        let anotherArbitraryIntervalAfterEpoch = Time.secsToDateTime(sec: anotherArbitrarySecs)
        anotherArbitraryIntervalAfterEpoch.printDate()
        XCTAssert(anotherArbitraryIntervalAfterEpoch.year == 1978)
        XCTAssert(anotherArbitraryIntervalAfterEpoch.month == 6)
        XCTAssert(anotherArbitraryIntervalAfterEpoch.day == 18)
        XCTAssert(anotherArbitraryIntervalAfterEpoch.hour == 0)
        XCTAssert(anotherArbitraryIntervalAfterEpoch.min == 2)
        XCTAssert(anotherArbitraryIntervalAfterEpoch.sec == 2)
    }
    
    func testFractionalSecs() {
        let dateTime = Time.secsToDateTime(sec: 0.88)
        XCTAssert(dateTime.sec == 0.88)
        // make sure rounding works
        XCTAssert(round(dateTime.sec) == 1)
    }
    
    // func testNegativeSecsToDateTime() {
    //     let timeEpoch = Time.secsToDateTime(sec: 0)
    //     print("Epoch")
    //     timeEpoch.printDate()
    //     XCTAssert(timeEpoch.year == 1970)
    //     XCTAssert(timeEpoch.month == 0)
    //     XCTAssert(timeEpoch.day == 1)
    //     XCTAssert(timeEpoch.hour == 0)
    //     XCTAssert(timeEpoch.min == 0)
    //     XCTAssert(timeEpoch.sec == 0)
    //     let yearBefore = Time.secsToDateTime(sec: -365 * 24 * 3600)
    //     XCTAssert(yearBefore.year == 1969)
    //     yearBefore.printDate()
    //     let dayBefore = Time.secsToDateTime(sec: -24 * 3600)
    //     XCTAssert(dayBefore.day == 31)
    //     XCTAssert(dayBefore.year == 1969)
    //     dayBefore.printDate()
    //     let secBefore = Time.secsToDateTime(sec: -1)
    //     secBefore.printDate()
    //     XCTAssert(secBefore.sec == 59)
    //     XCTAssert(secBefore.min == 59)
    //     XCTAssert(secBefore.hour == 23)
    // }
    
    
   
    // func testSubtractTime() {
    //     let time1 = Time.secsToDateTime(sec: 0) // epoch
    //     // subtract 1 sec
    //     let time0 = Time.secsToDateTime(sec: -1)
    //     let timetest0 = Time.addSecsToDateTime(dateTime: time1, sec: -1.0)
    //     XCTAssert(time0 == timetest0)
    //     time1.printDate()
    //     time0.printDate()
    //     timetest0.printDate()
    //     // subtract 90 sec
    //     let time01 = Time.secsToDateTime(sec: -90)
    //     let timetest01 = Time.addSecsToDateTime(dateTime: time1, sec: -90)
    //     XCTAssert(time01 == timetest01)
    //     time01.printDate()
    //     timetest01.printDate()
    //     let time2 = Time.addSecsToDateTime(dateTime: time1, sec: TimeInterval(-Time.secsIn365DayYear))
    //     let time2MinusYear = DateTime(era: Era.CE, year: 1969, month: 0, day: 1, hour: 0, min: 0, sec: 0)
    //     XCTAssert(time2 == time2MinusYear)
    //     time2.printDate()
    // }
    
    func testNSDateClass() {
        let date = Date()
        print("Date = \(date)")
        // playing around with remote dates, it looks like Date can only handle years upt to 3 million,
        // and seconds upt to E14.  Thus need for my only time handling class
        let remoteDate = Date(timeIntervalSince1970: 1E14)
        print("Remote date = \(remoteDate)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        print("Formatted remote date = \(dateFormatter.string(from: remoteDate))")
        print("Formatted today date = \(dateFormatter.string(from: date))")
    }
    
//    func testMoment() {
//        let moment = Moment()
//        print(moment.dateComponents.day)
//        moment.momentDate = Date()
//        let components = moment.dateComponents
//        print(components.year)
//        print(components.month)
//        print(components.hour)
//        print(components.minute)
//        print(components.second)
//        print(components.nanosecond)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy MMM dd HH:mm:ss.ZZZ"
//        print("today is \(dateFormatter.string(from: moment.momentDate))")
//        print(moment.dateComponents.hour)
//        moment.setTimeZone("UTC")
//        print("UTC hour = \(moment.dateComponents.hour)")
//        let year = moment.dateComponents.year
//        moment.addSec(sec: 365 * 3600 * 24)
//        XCTAssert(moment.dateComponents.year == year! + 1)
//        print(moment.dateComponents.year)
//    }
//    
    
    func testMomentFormatting() {
        let date = Date(timeIntervalSince1970: 0)
        let moment = Moment(date: date)
        print(moment.date)
        print(moment.formattedMoment())
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "y MMM d hh:mm:ss a"
        print(moment.time(dateFormatter: dateFormat))
        XCTAssert(moment.formattedMoment() == "CE 1970 Jan 1 12:00:00 AM")
    }
}
