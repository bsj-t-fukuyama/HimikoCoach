//
//  GameSceneViewModel.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/07.
//

import SwiftUI

struct DummyCharacter {
    var id: Int
    var name: String
    var rank: String
}

final class GameSceneViewModel: ObservableObject {
    let charactersArray: [DummyCharacter]
    @Published var currentIndex: Int = 0
    
    init(charactersArray: [DummyCharacter]) {
        self.charactersArray = charactersArray
    }
    
    var isFinished: Bool {
        if currentIndex < charactersArray.count {
            return false
        } else {
            return true
        }
    }
    
    func incrementIndex() {
        currentIndex += 1
    }

    func resetIndex() {
        currentIndex = 0
    }
}
