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
    let character1 = DummyCharacter(id: 1, name: "卑弥呼", rank: "B")
    let character2 = DummyCharacter(id: 2, name: "中大兄皇子", rank: "B")
    let character3 = DummyCharacter(id: 3, name: "聖徳太子", rank: "B")
    let character4 = DummyCharacter(id: 4, name: "福山", rank: "B")
    let character5 = DummyCharacter(id: 5, name: "ガリレオ・ガリレイ", rank: "S")
    
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
                                gvm.isOnSound = true
                            }
                        }
                        .navigationDestination(isPresented: $gvm.sceneIsPresented) {
                            GeometryReader {
                                SpriteView(scene: StartScene(
                                    size: $0.size,
                                    charactersArray: [
                                        character1,
                                        character2,
                                        character3,
                                        character4,
                                        character5
                                    ]
                                ))
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
