//
//  ProductViewModel.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation
import Combine

@MainActor
final class ProductViewModel: ObservableObject {

    @Published
    var products: [ProductResponse] = []

    @Published
    var isLoading = false

    @Published
    var errorMessage: String?

    private let service =
    ProductService()

    func loadProducts() async {

        isLoading = true

        errorMessage = nil

        do {

            products =
            try await service.getProducts()

        } catch {

            errorMessage =
            error.localizedDescription
        }

        isLoading = false
    }
}
