//
//  LoginResponse.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    let username: String
    let role: String
}
