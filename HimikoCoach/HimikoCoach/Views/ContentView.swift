//
//  ContentView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/02/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // タブの選択項目を保持する
    @State var selection = 1
    @State var isPresented = false

    var body: some View {
        ZStack {
            TabView {
                Tab("マップ", systemImage: "mappin.and.ellipse.circle") {
                    LocationView()
                        .onAppear {
                            self.isPresented = true
                        }
                }
                .badge(2)
                
                
                Tab("Account", systemImage: "person.crop.circle") {
                    //
                }
            }
            
            if isPresented {
                EventPopupView(isPresented: $isPresented, title: "タイトル")
            }
        }

    } // body
} // View

#Preview{
    ContentView()
}

