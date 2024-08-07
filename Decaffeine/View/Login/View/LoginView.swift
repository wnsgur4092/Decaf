//
//  LoginView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/8/2024.
//

import SwiftUI
import Lottie
import AuthenticationServices

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            lottieAnimationView
            onBoardingText
            Spacer()
            if #available(iOS 15.0, *) {
                signInWithAppleButton
                    .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert){}
            } else {
                // Fallback on earlier versions
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    fileprivate var lottieAnimationView: some View {
        LottieView(filename: "coffee")
            .frame(maxWidth: 300, maxHeight: 300)
    }

    fileprivate var onBoardingText: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Track your Caffeine")
                .font(.system(size: 28, weight: .bold))
            Text("Give up bad caffeine intake habits decreasing your well-being and become a better version of you")
                .font(.system(size: 20, weight: .regular))
                .opacity(0.8)
            Text("The guided average total caffeine ingestion is referenced by the WHO")
                .font(.system(size: 16, weight: .regular))
                .opacity(0.6)
        }
        .foregroundColor(.black)
        .multilineTextAlignment(.leading)
    }

    fileprivate var signInWithAppleButton: some View {
        SignInWithAppleButton(.signIn) { request in
            viewModel.generateNonce()
            request.requestedScopes = [.email, .fullName]
            request.nonce = viewModel.hashNonce()
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                viewModel.signInWithApple(authorization: authorization)
            case .failure(let error):
                viewModel.showError(error.localizedDescription)
            }
        }
        .frame(height: 45)
        .clipShape(Capsule())
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
