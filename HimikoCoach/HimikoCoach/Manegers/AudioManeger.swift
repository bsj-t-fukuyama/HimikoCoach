//
//  AudioManeger.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/20.
//

import AVFoundation

final class AudioManager {
    static let shared = AudioManager()
    
    var player: AVAudioPlayer?
    
    init(player: AVAudioPlayer? = nil) {
        self.player = player
        
        configureAudioSession()
    }
    
    private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.ambient, mode: .default, options: .mixWithOthers)
            try audioSession.setActive(true, options: [])
        } catch {
            print("Audio Session configuration failed: \(error.localizedDescription)")
        }
    }
    
    func playJumpupSound() {
        guard let url = Bundle.main.url(forResource: "jumpup", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("エラー: \(error.localizedDescription)")
        }
    }
    
    func playBoundSound() {
        guard let url = Bundle.main.url(forResource: "bound", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("エラー: \(error.localizedDescription)")
        }
    }
    
    func playGoAheadSound() {
        guard let url = Bundle.main.url(forResource: "goAhead", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("エラー: \(error.localizedDescription)")
        }
    }
    
    func stopGoAheadSound() {
        guard let url = Bundle.main.url(forResource: "goAhead", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.stop()
        } catch {
            print("エラー: \(error.localizedDescription)")
        }
    }
    
    func playAdventSound() {
        guard let url = Bundle.main.url(forResource: "advent", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("エラー: \(error.localizedDescription)")
        }
    }
}


extension AudioManager {
    private func stopSound() {
        var player: AVAudioPlayer = AVAudioPlayer()
        player.stop()
    }
    
    private func fadeOutAndStop() {
        guard let player = player else { return }
        
        // フェードアウトの実装
        let fadeDuration: TimeInterval = 3.0 // フェードアウトの長さ（秒）
        let fadeSteps = 50  // フェードアウトのステップ数
        let delay: TimeInterval = fadeDuration / TimeInterval(fadeSteps)
        
        DispatchQueue.global(qos: .background).async {
            for step in 0..<fadeSteps {
                let volume = 1 - Float(step) / Float(fadeSteps)
                DispatchQueue.main.async {
                    player.setVolume(volume, fadeDuration: delay)
                }
                Thread.sleep(forTimeInterval: delay)
            }
            DispatchQueue.main.async {
                player.stop()
            }
        }
    }
}
