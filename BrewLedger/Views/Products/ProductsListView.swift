//
//  ProductsListView.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import SwiftUI

struct ProductsListView: View {

    @StateObject
    private var viewModel =
    ProductViewModel()

    var body: some View {

        Group {

            if viewModel.isLoading {

                ProgressView()

            } else if let error =
                        viewModel.errorMessage {

                Text(error)

            } else {

                Table(viewModel.products) {

                    TableColumn("Code") {

                        product in

                        Text(product.code)
                    }

                    TableColumn("Name") {

                        product in

                        Text(product.name)
                    }

                    TableColumn("Category") {

                        product in

                        Text(
                            product.categoryName
                        )
                    }

                    TableColumn("Price") {

                        product in

                        Text(
                            "Rp \(Int(product.sellingPrice))"
                        )
                    }
                }
            }
        }
        .navigationTitle(
            "Products"
        )
        .task {

            await viewModel.loadProducts()
        }
    }
}

#Preview {

    ProductsListView()
}
