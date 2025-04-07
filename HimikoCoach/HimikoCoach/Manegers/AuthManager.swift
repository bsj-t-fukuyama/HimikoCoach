//
//  AuthManager.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/06.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AuthManager: ObservableObject {
    static let shared: AuthManager = .init()
    @Published var isAuthenticated = false
    @Published var errMessage: String = ""
    
    // MARK - 画面表示系フラグ
    @Published var isShowSignInView: Bool = false
    @Published var isShowLoginView: Bool = false
    
    init() {
        observeAuthChanges()
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if result != nil, error == nil {
                    self?.isAuthenticated = true
                    return
                }
                
                self?.setErrorMessage(error)
            }
        }
    }

    private func observeAuthChanges() {
        _ = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isAuthenticated = user != nil
            }
        }
    }

    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if result != nil, error == nil {
                    self?.isAuthenticated = true
                    return
                }
                
                self?.setErrorMessage(error)
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    func setErrorMessage(_ error:Error?){
        if let error = error as NSError? {
            if let errorCode = AuthErrorCode(rawValue: error.code) {
                switch errorCode {
                case .invalidEmail:
                    self.errMessage = "メールアドレスの形式が違います。"
                case .emailAlreadyInUse:
                    self.errMessage = "このメールアドレスはすでに使われています。"
                case .weakPassword:
                    self.errMessage = "パスワードが弱すぎます。"
                case .userNotFound, .wrongPassword:
                    self.errMessage = "メールアドレス、またはパスワードが間違っています"
                case .userDisabled:
                    self.errMessage = "このユーザーアカウントは無効化されています"
                default:
                    self.errMessage = "予期せぬエラーが発生しました。\nしばらく時間を置いてから再度お試しください。"
                }
            }
        }
    }
}

extension AuthManager {
    func closeLoginView() {
        isShowLoginView = false
    }
}
