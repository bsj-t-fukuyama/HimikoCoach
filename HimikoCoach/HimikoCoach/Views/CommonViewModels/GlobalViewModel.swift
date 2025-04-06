//
//  GlobalViewModel.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/30.
//

//import Combine
import SwiftUI
//import SwiftyUserDefaults

final class GlobalViewModel: ObservableObject {
    static let shared: GlobalViewModel = .init()
    
    @Published var isShowTab = true
    @Published var sceneIsPresented = false
    @Published var isOnSound = false
    
    var isShowTabForVisiblity: Visibility {
        isShowTab ? .visible : .hidden
    }
    
}
