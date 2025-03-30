//
//  LottieSampleView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/20.
//

import SwiftUI
import Lottie
import SpriteKit

struct LottieView: UIViewRepresentable {
    var filename: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}



struct LottieContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("Lottie1")
                    .frame(height: 700) // 画像の高さを指定（適宜調整）
            }
            LottieView(filename: "anime2") // JSONファイル名を入れてください
                .frame(width: .infinity)
                //.ignoresSafeArea()
        }
    }
}

#Preview {
    LottieContentView()
}
