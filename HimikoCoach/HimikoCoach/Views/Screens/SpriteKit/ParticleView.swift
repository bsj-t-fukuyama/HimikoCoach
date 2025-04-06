//
//  ParticleView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/04.
//

import SwiftUI
import SpriteKit

struct ParticleView: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let skView = SKView(frame: .zero)
        let scene = SKScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.backgroundColor = .clear
        
        if let particles = SKEmitterNode(fileNamed: "FireParticle.sks") {
            particles.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
            scene.addChild(particles)
        }
        
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        skView.backgroundColor = .clear

        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        // Update the view when needed
    }
}
