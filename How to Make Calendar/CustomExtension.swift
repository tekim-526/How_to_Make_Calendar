//
//  CustomExtension.swift
//  How to Make Calendar
//
//  Created by Kim TaeSoo on 2022/01/08.
//

import Foundation

extension Calendar {
    func generateDates(interval: DateInterval, dateComponents: DateComponents) -> [Date] {
        var dates: [Date] = [interval.start]
        enumerateDates(startingAfter: interval.start, matching: dateComponents, matchingPolicy: MatchingPolicy.nextTime ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                }
                else { stop = true }
            }
        }
        return dates
    }
}

extension DateFormatter {
    static var yearAndMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMMM"
        return formatter
    }
    static var weekDay: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }
    static var year: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    static var dayNumber: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "D"
        return formatter
    }
}

extension Date: Identifiable {
    public var id: String {
        description
    }
}
