//
//  AlertViewModel.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/07.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let alert: Alert
}

// swiftlint:disable function_default_parameter_at_end
final class AlertViewModel: ObservableObject {
    enum ButtonType {
        case `default`
        case cancel
        case destructive
    }

    static let shared = AlertViewModel()

    @Published var alert: AlertItem?

    func showAlert(
        title: String,
        message: String,
        primaryLable: String,
        primaryAction: (() -> Void)? = nil,
        primaryType: ButtonType = .default,
        secondaryLable: String,
        secondaryAction: (() -> Void)? = nil,
        secondaryType: ButtonType = .default
    ) {

        let alert: Alert = .init(
            title: Text(title),
            message: getMessage(message),
            primaryButton: getAlertButton(
                label: primaryLable,
                action: primaryAction,
                type: primaryType
            ),
            secondaryButton: getAlertButton(
                label: secondaryLable,
                action: secondaryAction,
                type: secondaryType
            )
        )

        Task { @MainActor in
            self.alert = AlertItem(alert: alert)
        }
    }
}

extension AlertViewModel {
    func hideAlert() {
        alert = nil
    }

    private func getMessage(_ message: String) -> Text? {
        return Text(message)
    }

    private func getAlertButton(label: String, action: (() -> Void)? = nil, type: ButtonType) -> Alert.Button {
        let labelText = Text(label)
        switch type {
        case .default:
            return .default(labelText, action: action)

        case .cancel:
            return .cancel(labelText, action: action)

        case .destructive:
            return .destructive(labelText, action: action)
        }
    }
}
