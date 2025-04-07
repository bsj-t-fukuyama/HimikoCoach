//
//  GameSceneViewModel.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/07.
//

import SwiftUI

final class GameSceneViewModel: ObservableObject {
    let stringArray: [String]
    @Published var currentIndex: Int = 1
    
    init(stringArray: [String]) {
        self.stringArray = stringArray
    }
    
    var isFinished: Bool {
        if currentIndex < stringArray.count {
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
