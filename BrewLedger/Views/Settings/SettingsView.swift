//
//  SettingsView.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject
    var session: SessionManager

    var body: some View {

        VStack(spacing: 20) {

            Text("Settings")
                .font(.largeTitle)

            Button("Logout") {

                session.logout()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}
