//
//  MasterLocationData.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/08.
//

import Foundation

struct MasterLocationData: Codable, Equatable, Hashable {
    var displayName: String
    var id: Int
    var latitude: Float
    var description: String
    var longitude: Float
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case id
        case latitude
        case description
        case longitude
    }
}
