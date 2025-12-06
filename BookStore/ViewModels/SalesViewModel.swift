//
//  SalesViewModel.swift
//  BookStore
//
//  Created by Vignesh Iyer on 12/5/25.
//

import Foundation
import Observation

@Observable
class SalesViewModel {
    var salesData = [Sale]()
    
    var totalSales: Int {
        salesData.reduce(0) { $0 + $1.quantity }
    }
    
    var lastTotalSales: Int = 0
    
    // this is a computed property so this is going to change a lot
    var salesByWeek: [(day: Date, sales: Int)] {
        let grouped = salesGroupedByWeek(sales: salesData)
        return totalSalesPerDate(salesByDate: grouped)
    }
    
    init() {
        // fetch the data
    }
    
    func salesGroupedByWeek(sales: [Sale]) -> [Date: [Sale]] {
        var salesByWeek: [Date: [Sale]] = [:]
        
        let calendar = Calendar.current
        for sale in sales {
            guard let startOfWeek = calendar.date(
                from: calendar.dateComponents([
                    .yearForWeekOfYear,
                    .weekOfYear
                ], from: sale.saleDate)
            ) else { continue }
            if salesByWeek[startOfWeek] != nil {
                salesByWeek[startOfWeek]!.append(sale)
            } else {
                salesByWeek[startOfWeek] = [sale]
            }
        }
        
        return salesByWeek
    }
    
    func totalSalesPerDate(salesByDate: [Date: [Sale]]) -> [(day: Date, sales: Int)] {
        var totalSales: [(day: Date, sales: Int)] = []
        
        for (date, sales) in salesByDate {
            let totalQuantityForDate = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((day: date, sales: totalQuantityForDate))
        }
        
        return totalSales
    }
    
    static var preview: SalesViewModel {
        let vm = SalesViewModel()
        vm.salesData = Sale.threeMonthsExamples()
        vm.lastTotalSales = 500
        return vm
    }
}

