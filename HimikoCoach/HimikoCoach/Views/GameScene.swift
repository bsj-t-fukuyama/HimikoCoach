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
    @Published var audioManager = AudioManager.shared
    private var hostingController: UIViewController?

    override func didMove(to view: SKView) {
        // SwiftUIビューを追加
        backgroundColor = .black
        showOnlySwiftUIView(view: view)
        if gvm.isOnSound {
            self.audioManager.playGoAheadSound()
        }
    }
    
    private func showOnlySwiftUIView(view: SKView) {
        // SwiftUIのカスタムビューをレンダリング
        let swiftUIView = ParticleView().ignoresSafeArea()
        let hostingController = UIHostingController(rootView: swiftUIView)
        self.hostingController = hostingController
        
        hostingController.view.isUserInteractionEnabled = false // タッチイベントをブロックしないようにする

        // UIHostingControllerを子ビューコントローラとして追加
        if let parentView = view.superview {
            parentView.addSubview(hostingController.view)
            parentView.bringSubviewToFront(hostingController.view)

            // ナビゲーションバーの高さ分、SwiftUIビューをスクリーン全体に合わせる
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: parentView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
            ])

            // SwiftUIビューの背景色を透明に設定
            hostingController.view.backgroundColor = .clear
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 次のシーンへ遷移
        if let hostingController = hostingController {
            let nextScene = FirstScene(size: size, hostingController: hostingController)
            view?.presentScene(nextScene, transition: .init(ciFilter: CIFilter(name: "CIAccordionFoldTransition")!, duration: 1.0))
        }
    }
}

final class FirstScene: SKScene {
    @Published var gvm = GlobalViewModel.shared
    @Published var audioManager = AudioManager.shared
    private var hostingController: UIViewController

    init(size: CGSize, hostingController: UIViewController) {
        self.hostingController = hostingController
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        let text = SKLabelNode(text: "On Tap Screen!")
        text.fontName = "Helvetica-Bold"
        text.fontSize = 40
        text.fontColor = .white
        text.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        
        addChild(text)
    }
    
    //self?.hostingController.view.removeFromSuperview()が呼ばれない時があるのでこれも一応読んでおく
    override func willMove(from view: SKView) {
        // ParticleView を含む hostingController を削除
        hostingController.view.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let transitionDuration = 1.0

            // トランジションアニメーションの開始
            UIView.animate(withDuration: transitionDuration, animations: {
                // ここにアニメーションを追加する場合は記述
            }) { [weak self] _ in
                // ParticleView を含む hostingController を削除
                self?.hostingController.view.removeFromSuperview()
            }

            //音楽を止める
            audioManager.stopGoAheadSound()
            gvm.isOnSound = false
        
            // 次のシーンへ遷移
            let nextScene = SecondScene(size: size)
            view?.presentScene(nextScene, transition: .doorway(withDuration: transitionDuration))
        }
}


final class SecondScene: SKScene {
    @Published var audioManager = AudioManager.shared
    @Published var gvm = GlobalViewModel.shared

    override func didMove(to view: SKView) {
        Task { @MainActor in
            await Task.sleep(seconds: 0.5)
            audioManager.playAdventSound()
        }
        
        backgroundColor = .black
        let text = SKLabelNode(text: "GET!")
        text.fontName = "Helvetica-Bold"
        text.fontSize = 60
        text.fontColor = .white
        text.position = CGPoint(x: view.frame.midX, y: view.frame.midY + 130) // 上に配置
        text.zPosition = 1 // 前面に配置
        
        addChild(text)
        
        // 画像の表示
        let imageNode = SKSpriteNode(imageNamed: "Himiko") // 画像名を指定
        imageNode.position = CGPoint(x: view.frame.midX, y: view.frame.midY - 30)
        //imageNode.size = CGSize(width: 300, height: 300) // 画面サイズに合わせて設定
        imageNode.zPosition = 0 // 背面に配置
        
        addChild(imageNode)
        
        let backtext = SKLabelNode(text: "Back To war!")
        backtext.fontName = "Helvetica-Bold"
        backtext.fontSize = 25
        backtext.fontColor = .white
        backtext.position = CGPoint(x: view.frame.midX, y: view.frame.midY - 240) // 画面下部に配置
        backtext.zPosition = 1 // 前面に配置
        
        addChild(backtext)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view?.presentScene(StartScene(size: size), transition: .doorway(withDuration: 1.0))
        
        Task { @MainActor in
            gvm.sceneIsPresented = false
            gvm.isShowTab = true
        }
    }
}
