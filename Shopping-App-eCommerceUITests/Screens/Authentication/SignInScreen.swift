//
//  SignInScreen.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 14/04/2024.
//

import Foundation
import XCTest

class SignInScreen: BaseScreen {
    
    private lazy var title1 = app.staticTexts.matching(identifier: "Title1").element
    private lazy var title2 = app.staticTexts.matching(identifier: "Title2").element
    private lazy var emailTextField = app.textFields.matching(identifier: "EmailTextField").element
    private lazy var passwordTextField = app.secureTextFields.matching(identifier: "PasswordSecureTextField").element
    private lazy var signInButton = app.buttons.matching(identifier: "SignInButton").element
    private lazy var forgotPasswordButton = app.buttons.matching(identifier: "ForgotPasswordButton").element
    
    func enterCredentials(email: String, password: String) -> Self {
        XCTContext.runActivity(named: String(format: Constants.stepLog, "Entering credentials - Email: \(email) - Password: \(password)")) { _ in
            emailTextField.tap()
            emailTextField.typeText(email)
            passwordTextField.tap()
            passwordTextField.typeText(password)
            dismissKeyboardIfPresent()
            return self
        }
    }
    
    func tapSignInButton() {
        XCTContext.runActivity(named: String(format: Constants.stepLog, "Clicking (Sign in) Button")) { _ in
            signInButton.tap()
        }
    }
    
    func tapForgotPasswordButton() {
        XCTContext.runActivity(named: String(format: Constants.stepLog, "Clicking (Forgot password) Button")) { _ in
            forgotPasswordButton.tap()
        }
    }
    
    func verifyScreenElements() {
        XCTContext.runActivity(named: String(format: Constants.stepLog, "Checking Sign in Screen content")) { _ in
            title1.checkText("Hello,")
            title2.checkText("Sign in!")
            emailTextField.checkHint("enter your mail")
            passwordTextField.checkHint("enter your password")
            signInButton.checkText("Sign in")
            forgotPasswordButton.checkText("Forgot password")
        }
    }
    
}
