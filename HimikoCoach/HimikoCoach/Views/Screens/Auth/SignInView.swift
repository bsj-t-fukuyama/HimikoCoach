//
//  SignInView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/04.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    @StateObject var authManager = AuthManager.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("新規登録")
                        .fontWeight(.heavy)
                        .padding(.top, 30)
                    
                    VStack(alignment: .leading) {
                        Text("メール:")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        TextField("メアドを入力してください", text: $viewModel.email)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                        
                        if authManager.errMessage != "" {
                            Text(authManager.errMessage)
                                .font(.footnote) // フォントを小さくします
                                .fontWeight(.regular) // フォントの太さを'normal'にします
                                .foregroundColor(Color.red.opacity(0.7)) // 色を薄くします（70％の不透明度）
                        }
                        
                        VStack(alignment: .leading) {
                            Text("パスワード:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            TextField("パスワードを入力してください", text: $viewModel.password)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                        }
                    }
                    .padding(12)
                    
                    floatButton
                        .padding(.vertical ,20)
                }
            }
            .padding(.horizontal, 12)
            .onTapGesture {
                viewModel.endEditing()
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        authManager.isShowSignInView = false
                    }) {
                        Text("戻る")
                            .foregroundStyle(Color("BrandColor"))
                    }
                }
            }
        }
    }
    
    private var floatButton: some View {
        Group {
            if viewModel.checkEmailAndPasswordIsValid {
                Button(action: {
                    viewModel.createUser()
                }) {
                    HStack {
                        Spacer()
                        Text("確定")
                            .font(.system(size: 17).bold())
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                    .background(Color("BrandColor"))
                    .cornerRadius(8)
                    
                }
            } else {
                HStack {
                    Spacer()
                    Text("確定")
                        .font(.system(size: 17).bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                .background(Color.gray)
                .cornerRadius(8)
            }
        }
    }
}
