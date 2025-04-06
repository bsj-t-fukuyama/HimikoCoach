//
//  ContentView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/02/20.
//

import SwiftUI
import CoreData
import SpriteKit

struct ContentView: View {
    // タブの選択項目を保持する
    @State var selection = 1
    @State var isPresented = false
    @StateObject private var gvm = GlobalViewModel.shared
    @StateObject var authManager: AuthManager = .shared

    var body: some View {
        if authManager.isAuthenticated {
            ZStack {
                TabView {
                    Tab("マップ", systemImage: "mappin.and.ellipse.circle") {
                        LocationView()
                            .onAppear {
                                self.isPresented = true
                            }
                    }
                    .badge(2)
                    
                    Tab("戦力強化", systemImage: "person.crop.circle") {
                        ConscriptionView()
                    }
                    
                    Tab("実績", systemImage: "person.crop.circle") {
                        AccountView()
                    }
                }
                
                if isPresented {
                    EventPopupView(isPresented: $isPresented, title: "タイトル")
                }
            }
        } else {
            AuthView()
        }
    }
}

