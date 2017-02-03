//
//  Date+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 16/10/25.
//  Copyright © 2016年 Galaxy.Inc. All rights reserved.
//

import Foundation

public extension Date {
    
    // MARK: - compare
    
    public var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    public var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    public var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    public var isThisWeek: Bool {
        return isEqual(granularity: .weekOfYear)
    }
    
    public var isThisMonth: Bool {
        return isEqual(granularity: .month)
    }
    
    public var isThisYear: Bool {
        return isEqual(granularity: .year)
    }
    
    public func isSameDay(_ date: Date) -> Bool {
        return isEqual(date, granularity: .day)
    }
    
    public func isEqual(_ date: Date = Date(), granularity: Calendar.Component) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: granularity)
    }
    
    public func isEqual(_ date: Date = Date(), componentSet: Set<Calendar.Component>) -> Bool {
        let selfComponents = Calendar.current.dateComponents(componentSet, from: self)
        let otherComponents = Calendar.current.dateComponents(componentSet, from: date)
        for component in componentSet {
            guard let lhs = selfComponents.value(for: component),
                let rhs = otherComponents.value(for: component) else {
                    return false
            }
            if lhs == rhs {
                continue
            } else {
                return false
            }
        }
        return true
    }
    
    // MARK: - property getter
    
    public static let secondsInOneMinute: TimeInterval  = 60
    public static let secondsInOneHour: TimeInterval  = 60 * 60
    public static let secondsInOneDay: TimeInterval  = 60 * 60 * 24
    public static let secondsInOneWeek: TimeInterval  = 60 * 60 * 24 * 7
    
    public static let allComponentSet: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone]
    
    public var allComponents: DateComponents {
        return Calendar.current.dateComponents(Date.allComponentSet, from: self)
    }
    
    @available(iOS 8.0, macOS 10.9, *)
    public func component(_ unit: Calendar.Component) -> Int {
        return Calendar.current.component(unit, from: self)
    }
    
    public var era: Int {
        return component(.era) // return allComponents.era
    }
    
    public var year: Int {
        return component(.year)
    }
    
    public var month: Int {
        return component(.month)
    }
    
    public var day: Int {
        return component(.day)
    }
    
    public var hour: Int {
        return component(.hour)
    }
    
    public var minute: Int {
        return component(.minute)
    }
    
    public var second: Int {
        return component(.second)
    }
    
    public var weekday: Int {
        return component(.weekday)
    }
    
    public var weekdayOrdinal: Int {
        return component(.weekdayOrdinal)
    }
    
    public var quarter: Int {
        return component(.quarter)
    }
    
    public var weekOfMonth: Int {
        return component(.weekOfMonth)
    }
    
    public var weekOfYear: Int {
        return component(.weekOfYear)
    }
    
    public var yearForWeekOfYear: Int {
        return component(.yearForWeekOfYear)
    }
    
    public var nanosecond: Int {
        return component(.nanosecond)
    }
    
    public var calendar: Int {
        return component(.calendar)
    }
    
    public var timeZone: Int {
        return component(.timeZone)
    }
    
    public var isLeapMonth: Bool {
        return allComponents.isLeapMonth ?? false
    }
    
    public var isLeapYear: Bool {
        return (year % 100 == 0) ? (year % 400 == 0) : (year % 4 == 0)
    }
    
    // MARK: - calculate.
    
    // MARK: All calculations depend on time interval , not `Calendar`.
    
    public func addingMinutes(_ count: Int) -> Date {
        return self + TimeInterval(Date.secondsInOneMinute * Double(count))
    }
    
    public func subtractingMinutes(_ count: Int) -> Date {
        return addingMinutes(-count)
    }
    
    public func addingDays(_ count: Int) -> Date {
        return self + TimeInterval(Date.secondsInOneDay * Double(count)) // equals to  `self.addingTimeInterval(TimeInterval(Date.secondsInOneDay * Double(count)))`
    }
    
    public func subtractingDays(_ count: Int) -> Date {
        return addingDays(-count)
    }
    
    public func addingWeeks(_ count: Int) -> Date {
        return self + TimeInterval(Date.secondsInOneWeek * Double(count))
    }
    
    public func subtractingWeeks(_ count: Int) -> Date {
        return addingWeeks(-count)
    }
    
    // MARK: All calculations depend on `Calendar`, not time interval.
    
    public func addingMonths(_ count: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: count, to: self)
    }
    
    public func subtractingMonths(_ count: Int) -> Date? {
        return addingMonths(-count)
    }
    
    public func addingYears(_ count: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: count, to: self)
    }
    
    public func subtractingYears(_ count: Int) -> Date? {
        return addingYears(-count)
    }
    
    // MARK: other calculations.
    
    public var isThisWeekInChina: Bool {
        return self.isSameWeekInChina(Date())
    }
    
    public func isSameWeekInChina(_ date: Date) -> Bool {
        return subtractingDays(weekdayIndexInChina).isSameDay(date.subtractingDays(date.weekdayIndexInChina))
    }
    
    public var weekdayIndex: Int {
        return (weekday + 6) % 7
    }
    
    public var weekdayIndexInChina: Int {
        return (weekday + 5) % 7
    }
    
    // MARK: - interval
    
    public func timeInterval(_ to: Date = Date()) -> TimeInterval {
        return to.timeIntervalSince(self)
    }
    
    public func interval(_ component: Calendar.Component, _ to: Date = Date()) -> Int? {
        let dateComponet = Calendar.current.dateComponents([component], from: self, to: to)
        return dateComponet.value(for: component)
    }
    
    public func secondsInterval(_ date: Date) -> Double {
        //        return interval(.second)
        return timeInterval()
    }
    
    public func minutesInterval(_ date: Date) -> Double {
        return timeInterval() / Double(Date.secondsInOneMinute)
    }
    
    public func hoursInterval(_ date: Date) -> Double {
        return timeInterval() / Double(Date.secondsInOneHour)
    }
    
    public func daysInterval(_ date: Date) -> Double {
        return timeInterval() / Double(Date.secondsInOneDay)
    }
    
    public func weeksInterval(_ date: Date) -> Double {
        return timeInterval() / Double(Date.secondsInOneWeek)
    }
    
    public func monthsInterval(_ date: Date) -> Int? {
        return interval(.month)
    }
    
    public func yearsInterval(_ date: Date) -> Int? {
        return interval(.year)
    }
    
    // MARK: - format string / create a date with format
    
    public func string(_ format: String, timeZone: TimeZone = TimeZone.current, locale: Locale = Locale.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return string(dateFormatter, timeZone: timeZone, locale: locale)
    }
    
    public func string(_ dateFormatter: DateFormatter, timeZone: TimeZone = TimeZone.current, locale: Locale = Locale.current) -> String {
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }
    
    public static let ISODateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }()
    
    public var ISOString: String {
        return Date.ISODateFormatter.string(from: self)
    }
    
    public static func date(_ date: String, format: String, timeZone: TimeZone = TimeZone.current, locale: Locale = Locale.current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter.date(from: date)
    }
    
    public static func date(_ ISOString: String) -> Date? {
        return Date.ISODateFormatter.date(from: ISOString)
    }
    
}
