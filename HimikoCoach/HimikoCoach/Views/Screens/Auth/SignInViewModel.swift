//
//  SignInViewModel.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/06.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

final class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    private let authManager: AuthManager = .shared
    
    init() {
        authManager.errMessage = ""
    }
    
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func createUser() {
        authManager.createUser(email: self.email, password: self.password)
    }
}
