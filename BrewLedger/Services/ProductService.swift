//
//  ProductService.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation

final class ProductService {

    func getProducts() async throws -> [ProductResponse] {
        try await NetworkClient.shared.request(
            endpoint: "/api/products"
        )
    }
}
