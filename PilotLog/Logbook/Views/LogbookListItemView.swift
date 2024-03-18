//
//  LogbookListItemView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct LogbookListItemView: View {
    //let entry: LogbookEntry
    let entry: Flight
    
    var body: some View {
        HStack {
            VStack {
                Text("\(entry.date?.formatted(Date.FormatStyle().day(.twoDigits)) ?? "")")
                    .font(.title)
                Text("\(entry.date?.formatted(Date.FormatStyle().month(.wide)) ?? "")")
                    .font(.caption)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color.accentBackground)
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
                //Text(String(format: "%.1f", entry.times.blockTimeClockFormat))
//                Text(entry.title())
//                    .font(.caption)
            }
        }
    }
}

//struct LogbookListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogbookListItemView(entry: LogbookEntry.sampleData)
//            .previewLayout(.sizeThatFits)
//
//    }
//}
