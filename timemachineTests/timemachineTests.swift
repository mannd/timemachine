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
        XCTAssert(Time.monthName[0] == "JAN")
        XCTAssert(Time.monthName[1] == "FEB")
        XCTAssert(Time.monthName[2] == "MAR")
        XCTAssert(Time.monthName[3] == "APR")
        XCTAssert(Time.monthName[4] == "MAY")
        XCTAssert(Time.monthName[5] == "JUN")
        XCTAssert(Time.monthName[6] == "JUL")
        XCTAssert(Time.monthName[7] == "AUG")
        XCTAssert(Time.monthName[8] == "SEP")
        XCTAssert(Time.monthName[9] == "OCT")
        XCTAssert(Time.monthName[10] == "NOV")
        XCTAssert(Time.monthName[11] == "DEC")

    }
    
}
