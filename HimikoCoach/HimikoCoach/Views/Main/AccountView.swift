//
//  AccountView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/20.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var gvm = GlobalViewModel.shared
    
    var body: some View {
        VStack {
            HeaderView()
            
            ScrollView {
                Text("hoge")
                    .background(Color.red)
            }
        }
        .ignoresSafeArea()
        .toolbar(gvm.isShowTabForVisiblity, for: .tabBar)
    }
}

struct HeaderView: View {
    var body: some View {
        VStack {
            // MARK: TopMenuBar
            HStack(spacing: 0) {
                Spacer().frame(height: 50)
            }
            HStack(alignment: .center) {
                Text("戦績")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .padding(10)
        }
        .background(Color("BrandColor"))
    }
}

#Preview{
    AccountView()
}
