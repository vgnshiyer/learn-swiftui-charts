//
//  SimpleBookSalesView.swift
//  BookStore
//
//  Created by Vignesh Iyer on 12/6/25.
//

import SwiftUI
import Charts

struct SimpleBookSalesView: View {
    
    var salesViewModel: SalesViewModel
    
    var body: some View {
        VStack {
            if let changedBookSales = changedBookSales() {
                HStack {
                    Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right").bold().foregroundColor(isPositive ? .green : .red)
                    Text("Your book sales ") +
                    Text(changedBookSales)
                        .bold() +
                    Text(" in the last 90 days.")
                }
            }
            
            WeeklySalesChartView(salesViewModel: salesViewModel)
                .frame(height: 100)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
        }
    }
    
    var percentage: Double {
        Double(salesViewModel.totalSales) /
        Double(salesViewModel.lastTotalSales) - 1
    }
    
    var isPositive: Bool {
        percentage > 0
    }
    
    func changedBookSales() -> String? {
        let percentage = percentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changedDescription = percentage < 0 ? "decreased by " : "increased by "
        
        return changedDescription + formattedPercentage
    }
}

#Preview {
    SimpleBookSalesView(salesViewModel: SalesViewModel.preview)
        .padding()
}

#Preview("negative") {
    let decreasedVM = SalesViewModel.preview
    decreasedVM.lastTotalSales = 1000
    
    return SimpleBookSalesView(salesViewModel: decreasedVM).padding()
}
