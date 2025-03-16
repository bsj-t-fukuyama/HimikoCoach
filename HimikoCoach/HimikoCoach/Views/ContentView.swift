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

    var body: some View {
        
        TabView {
            Tab("マップ", systemImage: "mappin.and.ellipse.circle") {
                LocationView()
            }
            .badge(2)


            Tab("Account", systemImage: "person.crop.circle") {
                //LocationView()
            }
        }

    } // body
} // View

#Preview{
    ContentView()
}
