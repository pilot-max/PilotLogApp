//
//  LogbookListItemView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct LogbookListItemView: View {
    let entry: LogbookEntry
    
    var body: some View {
        HStack {
            VStack {
                Text("\(entry.date.formatted(Date.FormatStyle().day(.twoDigits)))")
                    .font(.title)
                Text("\(entry.date.formatted(Date.FormatStyle().month(.wide)))")
                    .font(.caption)
            }
            .frame(width: 75,height: 75)
//            .padding(.horizontal)
//            .padding(.vertical, 5)
            .background(Color.accentBackground)
            .foregroundColor(.primary)
            .cornerRadius(10)
            Spacer()
            VStack {
                //Text("\(entry.departure) - \(entry.arrival)")
                Text("ABCD - EFGH")
                Text("Flight")
                    .font(.caption)
            }
            Spacer()
            VStack {
                Text( entry.times.blockTimeClockFormat)
//                Text(entry.title())
//                    .font(.caption)
            }
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    LogbookListItemView(entry: LogbookEntry.factory())
}
