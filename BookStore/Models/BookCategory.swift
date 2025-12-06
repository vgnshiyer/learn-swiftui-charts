//
//  BookCategory.swift
//  BookStore
//
//  Created by Vignesh Iyer on 12/5/25.
//

import Foundation

enum BookCategory: String, Identifiable, CaseIterable {
    case fiction
    case biography
    case children
    case computerScience
    case fantasy
    case business
    
    var id: Self { self }
    
    var displayName: String {
        switch self {
            case .fiction:
                "Fiction"
            case .biography:
                "Biography"
            case .children:
                "Children Books"
            case .computerScience:
                "Computer Science"
            case .fantasy:
                "Fantasy"
            case .business:
                "Business"
        }
    }
}
