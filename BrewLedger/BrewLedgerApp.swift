//
//  BrewLedgerApp.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 29/05/26.
//

import SwiftUI

@main
struct BrewLedgerApp: App {

    @StateObject
    private var session =
        SessionManager()

    var body: some Scene {

        WindowGroup {

            if session.isLoggedIn {

                ContentView()

            } else {

                LoginView()
            }
        }
        .environmentObject(
            session
        )
    }
}
