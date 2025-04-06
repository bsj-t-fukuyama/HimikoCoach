//
//  GameScene.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/30.
//

import SpriteKit
import SwiftUI

final class StartScene: SKScene {
    @Published var gvm = GlobalViewModel.shared

    override func didMove(to view: SKView) {
//        // 画像の表示
//        let imageNode = SKSpriteNode(imageNamed: "Lottie1") // 画像名を指定
//        imageNode.position = CGPoint(x: view.frame.midX, y: view.frame.midY - 30)
//        imageNode.size = CGSize(width: 300, height: 300) // 画面サイズに合わせて設定
//        imageNode.zPosition = 0 // 背面に配置
//        
//        addChild(imageNode)
        
        // SwiftUIビューを追加
        addSwiftUIView(to: view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view?.presentScene(FirstScene(size: size), transition: .init(ciFilter: CIFilter(name: "CIAccordionFoldTransition")!, duration: 1.0))
    }
    
    private func addSwiftUIView(to skView: SKView) {
        // SwiftUIのカスタムビューをレンダリング
        let swiftUIView = LottieView(filename: "anime2")
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // UIHostingControllerを子ビューコントローラとして追加
        if let parentView = skView.superview {
            parentView.addSubview(hostingController.view)
            parentView.bringSubviewToFront(hostingController.view)
            
            // SwiftUIビューのサイズと位置設定
            hostingController.view.backgroundColor = .clear
            //hostingController.view.frame = CGRect(x: 50, y: 50, width: 300, height: 150) // 必要に応じて調整
        }
    }
}

final class FirstScene: SKScene {
    @Published var gvm = GlobalViewModel.shared

    override func didMove(to view: SKView) {
        let brandColor = Color("BrandColor")
        backgroundColor = .black
        
        let text = SKLabelNode(text: "On Tap Screen!")
        text.fontName = "Helvetica-Bold"
        text.fontSize = 40
        text.fontColor = .white
        text.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        
        addChild(text)
        
        // 底辺のみの囲いを作成
        let path = UIBezierPath()
        path.move(to: CGPoint(x: text.frame.minX, y: text.frame.minY))
        path.addLine(to: CGPoint(x: text.frame.maxX, y: text.frame.minY))
        
        let underline = SKShapeNode(path: path.cgPath)
        underline.strokeColor = .yellow
        underline.lineWidth = 10 // 囲いの太さ
        //underline.position = text.position.offsetBy(dx: -text.frame.width / 2, dy: -text.frame.height / 2)
        
        addChild(underline)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view?.presentScene(SecondScene(size: size), transition: .doorway(withDuration: 1.0))
    }
}

final class SecondScene: SKScene {
    @Published var gvm = GlobalViewModel.shared

    override func didMove(to view: SKView) {
        backgroundColor = .black
        let text = SKLabelNode(text: "GET!")
        text.fontName = "Helvetica-Bold"
        text.fontSize = 60
        text.fontColor = .white
        text.position = CGPoint(x: view.frame.midX, y: view.frame.midY + 130) // 上に配置
        text.zPosition = 1 // 前面に配置
        
        addChild(text)
        
        // 画像の表示
        let imageNode = SKSpriteNode(imageNamed: "MainImage") // 画像名を指定
        imageNode.position = CGPoint(x: view.frame.midX, y: view.frame.midY - 30)
        imageNode.size = CGSize(width: 300, height: 300) // 画面サイズに合わせて設定
        imageNode.zPosition = 0 // 背面に配置
        
        addChild(imageNode)
        
        let backtext = SKLabelNode(text: "Back To war!")
        backtext.fontName = "Helvetica-Bold"
        backtext.fontSize = 25
        backtext.fontColor = .white
        backtext.position = CGPoint(x: view.frame.midX, y: view.frame.midY - 240) // 上に配置
        backtext.zPosition = 1 // 前面に配置
        
        addChild(backtext)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view?.presentScene(SecondScene(size: size), transition: .doorway(withDuration: 1.0))
        
        Task { @MainActor in
            gvm.sceneIsPresented = false
            gvm.isShowTab = true
        }
    }
}
