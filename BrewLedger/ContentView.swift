//
//  ContentView.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 29/05/26.
//

import SwiftUI

struct ContentView: View {

    @State
    private var selected: SidebarDestination?
    = .dashboard

    var body: some View {

        NavigationSplitView {

            List(
                SidebarDestination.allCases,
                selection: $selected
            ) {

                destination in

                Label(
                    destination.title,
                    systemImage:
                        destination.systemImage
                )
                .tag(destination)
            }

        } detail: {

            switch selected {

            case .dashboard:
                DashboardView()

            case .products:
                ProductsListView()

            case .ingredients:
                IngredientsListView()

            case .suppliers:
                SuppliersListView()

            case .purchaseOrders:
                PurchaseOrdersListView()

            case .transactions:
                TransactionsListView()

            case .settings:
                SettingsView()

            case .none:
                Text("Pilih Menu")
            }
        }
    }
}

#Preview {
    ContentView()
}
