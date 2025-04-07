//
//  AccountViewModel.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/07.
//

import Foundation

class AccountViewModel: ObservableObject {
    private let alertService: AlertServices = .shared
    private let authManager: AuthManager = .shared
        
    func showSignOutAlert() {
        alertService.showSignOutCheck {
        } secondaryAction: { [weak self] in
            self?.authManager.signOut()
        }
    }
}
