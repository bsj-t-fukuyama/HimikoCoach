//
//  ContentViewModel.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/08.
//

import Foundation
import SwiftyUserDefaults

final class ContentViewModel: ObservableObject {
    init() {
        onLaunch()
    }
    
    private func onLaunch() {
        setMasterLocationDatas()
        
        print("onLaunch")
    }
    
    private func setMasterLocationDatas() {
        let apiService = APIService()
        
        apiService.getAllLocations { result in
            switch result {
            case .success(let locations):
                // locations には取得された MasterLocationData の配列が含まれます
                print("-----\(locations)")
                for location in locations {
                    print("---:\(location)")
                }
            case .failure(let error):
                // エラー処理
                print("Error fetching locations: \(error)")
            }
        }
    }
}
