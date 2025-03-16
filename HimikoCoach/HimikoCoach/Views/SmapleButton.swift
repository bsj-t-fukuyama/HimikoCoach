//
//  SmapleButton.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/16.
//

import SwiftUI

struct GlassmorphismButton: View {
    let backGradientView: LinearGradient = LinearGradient(
        gradient: Gradient(
            colors: [.yellow, .pink]
        ),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    @State private var isTapped = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.yellow, .pink]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: .infinity, height: .infinity)
                    .rotation3DEffect(
                        .degrees(isTapped ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)  // Y軸を中心に回転
                    )
                    .animation(.easeInOut(duration: 0.4), value: isTapped)
                    .padding(20)
            Button(action: {
                Task {
                    isTapped.toggle()
                }
            }){
                Text("裏返すボタン")
                    .font(.system(size: 25, weight: .semibold, design: .default))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(.ultraThinMaterial)
                            .shadow(color: .init(white: 0.4, opacity: 0.4), radius: 5, x: 0, y: 0)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.init(white: 1, opacity: 0.5), lineWidth: 1)
                    )
                    //.scaleEffect(isTapped ? 1.2 : 1.0)
            }
        }
    }
}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async {
        let duration = UInt64(seconds * 1_000_000_000) //ナノ秒に直すために
        try? await Task.sleep(nanoseconds: duration)
    }
}
