//
//  GameScene.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/30.
//

import SpriteKit
//import SwiftUI

final class FirstScene: SKScene {
    @Published var gvm = GlobalViewModel.shared

    override func didMove(to view: SKView) {
        backgroundColor = .systemRed
        let text = SKLabelNode(text: "First")
        text.position = view.center
        addChild(text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view?.presentScene(SecondScene(size: size), transition: .doorway(withDuration: 1.0))
    }
}

final class SecondScene: SKScene {
    @Published var gvm = GlobalViewModel.shared

    override func didMove(to view: SKView) {
        backgroundColor = .systemBlue
        let text = SKLabelNode(text: "Second")
        text.position = view.center
        addChild(text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view?.presentScene(SecondScene(size: size), transition: .doorway(withDuration: 1.0))
        
        Task { @MainActor in
            gvm.sceneIsPresented = false
            gvm.isShowTab = true
        }
    }
}
