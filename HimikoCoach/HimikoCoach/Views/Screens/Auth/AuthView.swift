//
//  AuthView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/04.
//

import SwiftUI

struct AuthView: View {
    @StateObject var authManager = AuthManager.shared
    private var audioManager = AudioManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                ParticleView().ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("HimikoWar")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        authManager.isShowLoginView = true
                    }) {
                        Text("ログイン")
                            .font(.title)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(Color("BrandColor"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $authManager.isShowLoginView) {
                        LoginView()
                    }
                    
                    Button(action: {
                        authManager.isShowSignInView = true
                    }) {
                        Text("新規登録")
                            .font(.title)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("BrandColor"), lineWidth: 4)
                            )
                            .cornerRadius(10)
                            .padding(.vertical, 40)
                    }
                    .sheet(isPresented: $authManager.isShowSignInView) {
                        SignInView()
                    }
                    .padding(.bottom, 50)
                }
                .padding(.horizontal, 10)
            }
            .background(Color.black)
            .ignoresSafeArea() // ZStack全体に対してignoresSafeArea()を適用
        }
    }
}
