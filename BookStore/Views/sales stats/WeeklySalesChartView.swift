//
//  WeeklySalesChartView.swift
//  BookStore
//
//  Created by Vignesh Iyer on 12/5/25.
//

import SwiftUI
import Charts

struct WeeklySalesChartView: View {
    
    var salesViewModel: SalesViewModel
    
    @State private var rawSelectedDate: Date? = nil
    @Environment(\.calendar) var calendar
    
    var selectedDateValue: (day: Date, sales: Int)? {
        if let rawSelectedDate {
            return salesViewModel.salesByWeek.first {
                let startOfWeek = $0.day
                let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? Date()
                
                return (startOfWeek...endOfWeek).contains(rawSelectedDate)
            }
        } else {
            return nil
        }
    }
    
    private let monthInterval: TimeInterval = 3600 * 24 * 30
    
    var body: some View {
        VStack(alignment: .leading) {
            Chart {
                ForEach(salesViewModel.salesByWeek, id: \.day) { saleData in
                    BarMark(x: .value("Week", saleData.day, unit: .weekOfYear),
                            y: .value("Sales", saleData.sales))
                    .foregroundStyle(Color.blue.gradient)
                    .opacity(selectedDateValue?.day == nil || selectedDateValue?.day == saleData.day ? 1 : 0.5)
                }
                    
                if let rawSelectedDate {
                    RuleMark(x: .value("Selected Date", rawSelectedDate, unit: .weekOfYear))
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .zIndex(-1)
                        .annotation(position: .top, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            selectionTooltip
                        }
                }
            }
            .chartXSelection(value: $rawSelectedDate)
        }
    }
    
    @ViewBuilder
    var selectionTooltip: some View {
        if let selectedDateValue {
            VStack {
                Text(selectedDateValue.day.formatted(.dateTime.month().day()))
                Text("\(selectedDateValue.sales) sales")
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .shadow(color: .accentColor, radius: 2)
            }
        }
    }
}

#Preview {
    WeeklySalesChartView(salesViewModel: SalesViewModel.preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
