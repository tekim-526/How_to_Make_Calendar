//
//  ContentView.swift
//  How to Make Calendar
//
//  Created by Kim TaeSoo on 2022/01/03.
//

import SwiftUI

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView
    
    init(
        interval: DateInterval,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(months, id: \.self) { month in
                Section(header: header(for: month)) {
                    ForEach(days(for: month), id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month)  {
                            content(date).id(date)
                        } else {
                            content(date).hidden()
                        }
                    }
                }
            }
        }
    }
    
    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    
    private func header(for month: Date) -> some View {
        //let component = calendar.component(.month, from: month)
        let formatter = DateFormatter.monthAndYear
        
        return Group {
            if showHeaders {
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }
    
    private func days(for month: Date) -> [Date] {
        guard
            let monthInterval: DateInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek: DateInterval = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek: DateInterval = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}

struct RootView: View {
    @Environment(\.calendar) var calendar
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    var body: some View {
        ScrollView {
            CalendarView(interval: year) { date in
                //요 부분이 DateView라고 보면 되나..?
                Text(String(self.calendar.component(.day, from: date)))
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .padding(.vertical, 4)
            }
        }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView(interval: .init()) { _ in
//            Text("30")
//                .padding(8)
//                .background(Color.blue)
//                .cornerRadius(8)
//        }
//    }
//}

