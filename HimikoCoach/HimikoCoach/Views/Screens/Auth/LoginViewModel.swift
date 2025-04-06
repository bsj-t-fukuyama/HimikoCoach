//
//  LoginViewModel.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/06.
//
import SwiftUI
import FirebaseCore
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    private let authManager: AuthManager = .shared
    
    init() {
        authManager.errMessage = ""
    }
    
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func login() {
        authManager.logIn(email: self.email, password: self.password)
    }
}
