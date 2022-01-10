//
//  TopView.swift
//  How to Make Calendar
//
//  Created by Kim TaeSoo on 2022/01/10.
//

import SwiftUI

struct NavigationButtons: View {
    var year: Int
    var body: some View {
        HStack {
            Button {
                // MARK: 어떤기능을 넣을지 상의 해 봅시다..
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
                // MARK: Project 생성하는 부분이랑 연결..?
                print("King Tae Su")
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.yellow)
            }
        }.padding()
    }
}

struct ShowWeekDay: View {
    @Environment(\.calendar) var calendar
    let sevenDaysInterval: DateInterval = DateInterval(start: Date(timeIntervalSince1970: 60 * 60 * 24 * 3),
                                                       end: Date(timeIntervalSince1970: 60 * 60 * 24 * 9))
    
    private var weekDay: [Date] {
        calendar.generateDates(interval: sevenDaysInterval, dateComponents: DateComponents(hour: 0))
    }
    
    var body: some View {
        HStack(spacing: 0) {
            let formatter = DateFormatter.weekDay
            ForEach(weekDay, id: \.self) { day in
                if calendar.component(.weekday, from: day) == 1 || calendar.component(.weekday, from: day) == 7 {
                    Text(formatter.string(from: day))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
                else {
                    Text(formatter.string(from: day))
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
