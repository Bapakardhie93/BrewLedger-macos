//
//  SidebarDestination.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation

enum SidebarDestination: String, CaseIterable, Identifiable {

    case dashboard
    case products
    case ingredients
    case suppliers
    case purchaseOrders
    case transactions
    case settings

    var id: String {
        rawValue
    }

    var title: String {

        switch self {

        case .dashboard:
            return "Dashboard"

        case .products:
            return "Products"

        case .ingredients:
            return "Ingredients"

        case .suppliers:
            return "Suppliers"

        case .purchaseOrders:
            return "Purchase Orders"

        case .transactions:
            return "Transactions"

        case .settings:
            return "Settings"
        }
    }

    var systemImage: String {

        switch self {

        case .dashboard:
            return "chart.bar"

        case .products:
            return "cup.and.saucer"

        case .ingredients:
            return "shippingbox"

        case .suppliers:
            return "person.3"

        case .purchaseOrders:
            return "doc.text"

        case .transactions:
            return "cart"

        case .settings:
            return "gear"
        }
    }
}
