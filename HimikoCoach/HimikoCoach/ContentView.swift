//
//  ContentView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/02/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        GlassmorphismButton()
    }
}

struct GlassmorphismButton: View {
    let frontGradientView: LinearGradient = LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let backGradientView: LinearGradient = LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .offset(x: 50, y: 50)
                .foregroundStyle(backGradientView)
            Circle()
                .frame(width: 200, height: 200)
                .offset(x: -50, y: -50)
                .foregroundStyle(frontGradientView)
            Button(action: {
                print("button tapped")
            }){
                Text("Glassmorphism Button")
                    .font(.system(size: 25, weight: .semibold, design: .default))
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                        // ぼかし効果
                        // .ultraThinMaterialはiOS15から対応
                            .foregroundStyle(.ultraThinMaterial)
                        // ドロップシャドウで立体感を表現
                            .shadow(color: .init(white: 0.4, opacity: 0.4), radius: 5, x: 0, y: 0)
                    )
                    .overlay(
                        // strokeでガラスの縁を表現
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.init(white: 1, opacity: 0.5), lineWidth: 1)
                    )
            }
        }
    }
}

#Preview{
    ContentView()
}
