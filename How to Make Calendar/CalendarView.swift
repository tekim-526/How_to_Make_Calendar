//
//  CalendarView.swift
//  How to Make Calendar
//
//  Created by Kim TaeSoo on 2022/01/10.
//

import SwiftUI

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) private var calendar
    let interval: DateInterval
    let content: (Date, Date) -> DateView
    var index = 0
    var body: some View {
        
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7)) {
            ForEach(month, id: \.self) { month in
                Section {
                    ForEach(days(of: month), id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month){
                            content(date, month).id(date)
                        } else {
                            content(date, month).hidden()
                        }
                    }
                }
            }
        }
    }
    
    private var month: [Date] {
        calendar.generateDates(interval: DateInterval(start: interval.start, end: interval.end.addingTimeInterval(1)), dateComponents: DateComponents(day: 1))
    }
    
    private func days(of month: Date) -> [Date] {
        guard
            let monthInterval: DateInterval = calendar.dateInterval(of: .month, for: month),
            let firstWeekinterval: DateInterval = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let lastDayOfMonth: Date = calendar.date(byAdding: .day, value: -1, to: monthInterval.end),
            let lastWeekInterval: DateInterval = calendar.dateInterval(of: .weekOfMonth, for: lastDayOfMonth)
        else { return [] }
        return calendar.generateDates(interval: DateInterval(start: firstWeekinterval.start, end: lastWeekInterval.end), dateComponents: DateComponents(hour: 0))
    }
}
