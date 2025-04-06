//
//  LaunchView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/04.
//

import SwiftUI

struct LaunchView: View {
    @State private var isLoading = true
    
    var body: some View {
        if isLoading {
            ZStack {
                Color(.black)
                    .ignoresSafeArea() // ステータスバーまで塗り潰すために必要
                
                LottieView(filename: "anime2")
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        } else {
            ContentView()
        }
    }
}
