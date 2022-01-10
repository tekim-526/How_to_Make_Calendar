//
//  MainCalendar.swift
//  How to Make Calendar
//
//  Created by Kim TaeSoo on 2022/01/07.
//

import SwiftUI

struct DateView: View {
    @Environment(\.calendar) var calendar
    
    let date: Date
    let month: Date
    var body: some View {
        VStack(spacing: 15) {
            if String(calendar.component(.day, from: date)) == "1" {
                if (calendar.component(.year, from: date), calendar.component(.month, from: date)) ==
                    (calendar.component(.year, from: Date()), calendar.component(.month, from: Date())){
                    Text(DateFormatter.month.string(from: date))
                        .bold()
                        .foregroundColor(.yellow)
                }
                else {
                    Text(DateFormatter.month.string(from: date))
                        .bold()
                }
            }
            else {
                Text("\(String(calendar.component(.month, from: month)))월")
                    .hidden()
            }
            VStack(spacing: 0) {
                Divider()
                VStack(spacing: 0) {
                    ZStack {
                        if (calendar.component(.year, from: date), calendar.component(.month, from: date), calendar.component(.day, from: date)) ==
                            (calendar.component(.year, from: Date()), calendar.component(.month, from: Date()), calendar.component(.day, from: Date())) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.yellow)
                                .font(.title2)
                            Text(String(calendar.component(.day, from: date)))
                                .foregroundColor(.white)
                                .font(.footnote)
                                .padding()
                        }
                        else if calendar.component(.weekday, from: date) == 1 || calendar.component(.weekday, from: date) == 7 {
                            Text(String(calendar.component(.day, from: date)))
                                .font(.footnote)
                                .foregroundColor(.gray)
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

