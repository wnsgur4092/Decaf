//
//  LoginViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/8/2024.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import CryptoKit

class LoginViewModel: ObservableObject {
    @Published var logStatus: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var nonce: String?

    func signInWithApple(authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            showError("Invalid credentials provided.")
            return
        }

        guard let nonce = nonce,
              let appleIDToken = appleIDCredential.identityToken,
              let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            showError("Unable to process your request.")
            return
        }

        let credential = OAuthProvider.appleCredential(withIDToken: idTokenString, rawNonce: nonce, fullName: appleIDCredential.fullName)
        Auth.auth().signIn(with: credential) { [weak self] _, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.showError(error.localizedDescription)
                return
            }
            self.logStatus = true
        }
    }

    func generateNonce() {
        nonce = randomNonceString()
    }

    func hashNonce() -> String {
        guard let nonce = nonce else { return "" }
        return sha256(nonce)
    }

    func showError(_ message: String) {
        errorMessage = message
        showAlert = true
    }

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        return randomBytes.map { byte in String(format: "%02x", byte) }.joined()
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.map { String(format: "%02x", $0) }.joined()
    }
}
