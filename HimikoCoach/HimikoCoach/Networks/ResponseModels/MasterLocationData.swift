//
//  MasterLocationData.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/08.
//

import Foundation

struct MasterLocationData: Codable, Equatable, Hashable {
    var id: Int
    var displayName: String
    var description: String
    var latitude: Float
    var longitude: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case description
        case latitude
        case longitude
    }
}
