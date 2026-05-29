//
//  ProductResponse.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation

struct ProductResponse: Codable, Identifiable {

    let id: Int

    let code: String

    let name: String

    let categoryName: String

    let sellingPrice: Double

    let description: String?

    
    let active: Bool
}
