//
//  ContentView.swift
//  BookStore
//
//  Created by Vignesh Iyer on 12/5/25.
//

import SwiftUI

struct ContentView: View {
    
    var salesViewModel = SalesViewModel.preview
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    DetailBookSalesView(salesViewModel: salesViewModel)
                } label: {
                    SimpleBookSalesView(salesViewModel: salesViewModel)
                }
                
                NavigationLink {
                    SalesByWeekday(salesViewModel: salesViewModel)
                } label: {
                    SimpleSalesByWeekday(salesViewModel: salesViewModel)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Book Store Stats")
        }
    }
}

#Preview {
    ContentView()
}
