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
}
