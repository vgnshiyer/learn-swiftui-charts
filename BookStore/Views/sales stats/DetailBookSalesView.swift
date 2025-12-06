//
//  DetailBookSalesView.swift
//  BookStore
//
//  Created by Vignesh Iyer on 12/6/25.
//

import SwiftUI

struct DetailBookSalesView: View {
    
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        
        var id: Self { self }
    }
    
    var salesViewModel: SalesViewModel
    @State private var selectedTimeInterval: TimeInterval = .day
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases) { interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("Time Interval")
            }
            .pickerStyle(.segmented)
            
            Group {
                Text("You sold ") +
                Text("\(salesViewModel.totalSales) books").bold().foregroundColor(.accentColor) +
                Text(" in the last 90 days.")
            }
            .padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                case .day:
                    DailySalesChartView(salesData: salesViewModel.salesData)
                case .week:
                    WeeklySalesChartView(salesViewModel: salesViewModel)
                case .month:
                    MonthlySalesChartView(salesData: salesViewModel.salesData)
                }
            }
            .aspectRatio(0.9, contentMode: .fit)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailBookSalesView(salesViewModel: SalesViewModel.preview)
}
