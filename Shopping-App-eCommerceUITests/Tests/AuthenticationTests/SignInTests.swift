//
//  AuthenticationTests.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 14/04/2024.
//

import Foundation

class SignInTests: BaseTest {
    
    func test_verify_welcome_and_sign_in_screen_elements() {
        WelcomeScreen(app)
            .verifyScreenElements()
            .tapSignInButton()
            .verifyScreenElements()
    }
    
    func test_email_badly_formatted() {
        WelcomeScreen(app)
            .tapSignInButton()
            .enterCredentials(email: InvalidUser.badlyFormattedEmail, password: InvalidUser.invalidPassword)
            .tapSignInButton()
        DialogWindow(app)
            .checkDialogContent(title: AuthenticationTexts.errorTitle, message: AuthenticationTexts.badlyFormattedEmailMessage)
            .dismissDialog()
    }
    
    func test_no_user_with_this_id() {
        WelcomeScreen(app)
            .tapSignInButton()
            .enterCredentials(email: InvalidUser.invalidEmail, password: InvalidUser.invalidPassword)
            .tapSignInButton()
        DialogWindow(app)
            .checkDialogContent(title: AuthenticationTexts.errorTitle, message: AuthenticationTexts.noUserWithThisIdMessage)
            .dismissDialog()
        
    }
    
    func test_invalid_password() {
        WelcomeScreen(app)
            .tapSignInButton()
            .enterCredentials(email: ValidUser.email, password: InvalidUser.invalidPassword)
            .tapSignInButton()
        DialogWindow(app)
            .checkDialogContent(title: AuthenticationTexts.errorTitle, message: AuthenticationTexts.invalidPasswordMessage)
            .dismissDialog()
    }
    
    func test_successful_sign_in() {
        WelcomeScreen(app)
            .tapSignInButton()
            .enterCredentials(email: ValidUser.email, password: ValidUser.password)
            .tapSignInButton()
        HomeScreen(app)
            .verifyScreenElements()
    }
}
