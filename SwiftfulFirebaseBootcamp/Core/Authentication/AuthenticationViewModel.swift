//
//  AuthenticationViewModel.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 13/9/25.
//

import Foundation


@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    let signInAppleHelper = SignInAppleHelper()
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
    }
    
    func signInAnonymous() async throws {
        try await AuthenticationManager.shared.signInAnonymous()
    }
}
