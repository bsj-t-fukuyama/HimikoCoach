//
//  ConscriptionView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/30.
//

import SwiftUI
import SpriteKit

struct ConscriptionView: View {
    @StateObject private var gvm = GlobalViewModel.shared
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    Text("邪馬台国強化ガチャ開始")
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                        .onTapGesture {
                            Task { @MainActor in
                                gvm.sceneIsPresented = true
                                gvm.isShowTab = false
                                print(gvm.isShowTab)
                            }
                        }
                        .navigationDestination(isPresented: $gvm.sceneIsPresented) {
                            GeometryReader {
                                SpriteView(scene: FirstScene(size: $0.size))
                                    .edgesIgnoringSafeArea(.all)
                                    .navigationBarBackButtonHidden(true)
                            }
                        }
                }
            }
        }
        .ignoresSafeArea()
        .toolbar(gvm.isShowTabForVisiblity, for: .tabBar)
    }
}

struct ConscriptionHeaderView: View {
    var body: some View {
        VStack {
            // MARK: TopMenuBar
            HStack(spacing: 0) {
                Spacer().frame(height: 50)
            }
            HStack(alignment: .center) {
                Text("戦力強化")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .padding(10)
        }
        .background(Color("BrandColor"))
    }
}
