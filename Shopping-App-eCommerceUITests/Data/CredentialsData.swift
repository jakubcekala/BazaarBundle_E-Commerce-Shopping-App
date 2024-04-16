//
//  CredentialsData.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 16/04/2024.
//

import Foundation

struct ValidUser {
    static let email = "qbx10789@fosiq.com"
    static let password = "auto_test"
}

struct InvalidUser {
    static let badlyFormattedEmail = "test"
    static let invalidEmail = "test@test.pl"
    static let invalidPassword = "test"
}
