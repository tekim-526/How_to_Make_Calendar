//
//  ContentView.swift
//  How to Make Calendar
//
//  Created by Kim TaeSoo on 2022/01/03.
//

// MARK: 활용 해 보자 if DateFormatter.yearAndMothAndDay.string(from: date) == DateFormatter.yearAndMothAndDay.string(from: date)

import SwiftUI

struct NavigationButtons: View {
    var year: Int
    var body: some View {
        HStack {
            Button {
                print(year)
            } label: {
                HStack {
                    Image(systemName: "chevron.backward")
                    Text(String(year))
                }
                .foregroundColor(.yellow)
            }
            Spacer()
            Button {
                print("King Tae Su")
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.yellow)
            }
        }.padding()
    }
}

struct WholeCalendar: View {
    @Environment(\.calendar) var calendar
    let interval: DateInterval = DateInterval(start: Date(timeIntervalSinceNow: -60 * 60 * 3650 * 24),
                                              end: Date(timeIntervalSinceNow: 60 * 60 * 24 * 3650))
    let sevenDaysInterVal: DateInterval = DateInterval(start: Date(timeIntervalSince1970: 60 * 60 * 24 * 3), end: Date(timeIntervalSince1970: 60 * 60 * 24 * 9))
    
    @State var year: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
                ScrollViewReader{ value in
                    NavigationButtons(year: year)
                    showWeekDay(symbol: createAnArrayToDisplayWeekDay)
                    Divider()
                    ScrollView(.vertical, showsIndicators: false) {
                        CalendarView(interval: interval) { date, month in
                            DateView(date: date, month: month)
                                .onAppear {
                                    if Int(DateFormatter.year.string(from: date)) != year {
                                        year = Int(DateFormatter.year.string(from: date))!
                                    }
                                }
                        }
                    }.onAppear(){
                        value.scrollTo(calendar.dateInterval(of: .month, for: Date())?.start, anchor: .top)
                    }
                }
            }
    }
    
    private func showYear(for month: Date) -> some View {
        let formatter = DateFormatter.year
        return Text(formatter.string(from: month)).padding()
    }
    
    private func showWeekDay(symbol: [Date]) -> some View {
        HStack(spacing: 0) {
            let formatter = DateFormatter.weekDay
            ForEach(symbol, id: \.self) { day in
                Text(formatter.string(from: day))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: . infinity)
            }
        }
    }

    private var createAnArrayToDisplayWeekDay: [Date] {
        calendar.generateDates(interval: sevenDaysInterVal, dateComponents: DateComponents(hour: 0))
    }
    private var createYears: [Date] {
        calendar.generateDates(interval: interval, dateComponents: DateComponents(month: 1))
    }
    private var createMonths: [Date] {
        calendar.generateDates(interval: interval, dateComponents: DateComponents(day: 1))
    }
}

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
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
    private func showYear(for month: Date) -> some View {
        let formatter = DateFormatter.year
        return Text(formatter.string(from: month)).padding()
    }
    private var createMonths: [Date] {
        calendar.generateDates(interval: interval, dateComponents: DateComponents(day: 1))
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

struct DateView: View {
    @Environment(\.calendar) var calendar
    
    let date: Date
    let month: Date
    var body: some View {
        VStack(spacing: 15) {
            if String(calendar.component(.day, from: date)) == "1" {
                Text("\(String(calendar.component(.month, from: month)))월")
                    .bold()
            }
            else {
                Text("\(String(calendar.component(.month, from: month)))월")
                    .hidden()
            }
            VStack(spacing: 0) {
                Divider()
                VStack(spacing: 0) {
                    ZStack {
                        if (calendar.component(.month, from: date), calendar.component(.day, from: date)) ==
                            (calendar.component(.month, from: Date()), calendar.component(.day, from: Date())) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.yellow)
                                .font(.title2)
                            Text(String(calendar.component(.day, from: date)))
                                .foregroundColor(.white)
                                .font(.footnote)
                                .padding()
                        }
                        else {
                            Text(String(calendar.component(.day, from: date)))
                                .font(.footnote)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}


