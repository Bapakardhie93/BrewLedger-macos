//
//  DashboardResponse.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation

struct DashboardResponse: Codable {

    let totalProducts: Int

    let totalIngredients: Int

    let totalSuppliers: Int

    let totalTransactions: Int

    let totalSales: Double

    let totalStockMovements: Int
}
