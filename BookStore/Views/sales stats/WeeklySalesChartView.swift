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
    
    var body: some View {
        Chart(salesViewModel.salesByWeek, id: \.day) { saleData in
            BarMark(x: .value("Week", saleData.day, unit: .weekOfYear),
                    y: .value("Sales", saleData.sales))
            .foregroundStyle(Color.blue.gradient)
        }
    }
}

#Preview {
    WeeklySalesChartView(salesViewModel: SalesViewModel.preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
