//
//  AccountView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/20.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var gvm = GlobalViewModel.shared
    @StateObject private var alertViewModel = AlertViewModel.shared
    private var viewModel = AccountViewModel()
    
    var body: some View {
        VStack {
            HeaderView()
            
            ScrollView {
                Text("hoge")
                    .background(Color.red)
                
                Spacer()
                Button(action: {
                    print("ボタン")
                    
                    viewModel.showSignOutAlert()

                }) {
                    buttonView
                }
            }.padding(10)
        }
        .ignoresSafeArea()
        .toolbar(gvm.isShowTabForVisiblity, for: .tabBar)
        .alert(item: $alertViewModel.alert) { alertItem in
            alertItem.alert
        }
    }
    
    private var buttonView: some View {
        HStack {
            Spacer()
            Text("ログアウト")
                .font(.system(size: 17).bold())
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
        .background(Color.red)
        .cornerRadius(4)
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
