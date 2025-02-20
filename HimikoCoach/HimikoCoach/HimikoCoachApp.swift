//
//  HimikoCoachApp.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/02/20.
//

import SwiftUI

@main
struct HimikoCoachApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
