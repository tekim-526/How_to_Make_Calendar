//
//  ContentView.swift
//  How to Make Calendar
//
//  Created by Kim TaeSoo on 2022/01/03.
//

// MARK: 활용 해 보자 if DateFormatter.yearAndMothAndDay.string(from: date) == DateFormatter.yearAndMothAndDay.string(from: date)

import SwiftUI

struct WholeCalendar: View {
    @Environment(\.calendar) var calendar
    let interval: DateInterval = DateInterval(start: Date(timeIntervalSinceNow: -60 * 60 * 3650 * 24),//18250
                                              end: Date(timeIntervalSinceNow: 60 * 60 * 24 * 3650))
    
    @State var year: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader{ value in
                NavigationButtons(year: year)
                ShowWeekDay()
                Divider()
                ScrollView(.vertical, showsIndicators: false) {
                    CalendarView(interval: interval) { date, month in
                        DateView(date: date, month: month)
                            .onAppear() {
                                    if Int(DateFormatter.year.string(from: date)) != year &&
                                        ((calendar.component(.month, from: date) == 1 && calendar.component(.day, from: date) == 31) || (calendar.component(.month, from: date) == 12 && calendar.component(.day, from: date) == 1)) {
                                        year = calendar.component(.year, from: month)
                                    }
                            }
                    }
                }.onAppear(){
                        value.scrollTo(calendar.dateInterval(of: .month, for: Date())?.start, anchor: .top)
                    
                }
            }
        }
    }
    
}






