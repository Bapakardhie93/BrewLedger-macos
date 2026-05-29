//
//  TokenManager.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation

final class TokenManager {

    static let shared =
        TokenManager()

    private init() {}

    private let key =
        "jwt_token"

    func saveToken(
        _ token: String
    ) {

        UserDefaults.standard.set(
            token,
            forKey: key
        )
    }

    func getToken()
    -> String? {

        UserDefaults.standard.string(
            forKey: key
        )
    }

    func clearToken() {

        UserDefaults.standard.removeObject(
            forKey: key
        )
    }
}
