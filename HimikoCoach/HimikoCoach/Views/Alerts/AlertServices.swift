//
//  AlertServices.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/07.
//

import Foundation

final class AlertServices {
    static let shared: AlertServices = .init()
    private let alertViewModel = AlertViewModel.shared
    
    func showSignOutCheck(primaryAction: @escaping () -> Void, secondaryAction: @escaping () -> Void) {
        alertViewModel.showAlert(
            title: "ログアウト",
            message: "ログアウトしてよろしいですか？",
            primaryLable: "いいえ",
            primaryAction: { [weak self] in
                primaryAction()
                self?.alertViewModel.hideAlert()
            },
            primaryType: .cancel,
            secondaryLable: "はい",
            secondaryAction: { [weak self] in
                secondaryAction()
                self?.alertViewModel.hideAlert()
            },
            secondaryType: .default
        )
    }
}
