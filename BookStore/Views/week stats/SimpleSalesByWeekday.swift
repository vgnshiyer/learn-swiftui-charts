//
//  SimpleSalesByWeekday.swift
//  BookStore
//
//  Created by Vignesh Iyer on 12/6/25.
//

import SwiftUI
import Charts

struct SimpleSalesByWeekday: View {
    
    var salesViewModel: SalesViewModel
    
    var body: some View {
        VStack {
            if let highestSellingWeekday = salesViewModel.highestSellingWeekday {
                Text("Your highest selling day of the week is ") +
                Text("\(weekday(for: highestSellingWeekday.number)): ").bold().foregroundColor(.accentColor) +
                Text("\(highestSellingWeekday.sales) sales per day")
            }
            
            Chart(salesViewModel.averageSalesbyWeekday, id: \.number) {
                BarMark(x: .value("Weekday", weekday(for: $0.number)),
                        y: .value("average sales", $0.sales), width: .ratio(0.8)
                )
                .foregroundStyle(Color.accentColor.gradient)
                .opacity($0.number == salesViewModel.highestSellingWeekday?.number ? 1 : 0.5)
            }
            .frame(height: 70)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        }
    }
    
    let formatter = DateFormatter()
    
    func weekday(for number: Int) -> String {
        formatter.weekdaySymbols[number - 1].capitalized
    }
}

#Preview {
    SimpleSalesByWeekday(salesViewModel: SalesViewModel.preview)
}
