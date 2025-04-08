//
//  APIService.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/08.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// カスタムエラータイプ
enum APIError: Error {
    case invalidURL
    case noData
}

struct APIService {
    private var session = URLSession.shared
    
    func getAllLocations(completion: @escaping (Result<[MasterLocationData], Error>) -> Void) {
        let url = URL(string: "https://yppu14dpmd.execute-api.ap-northeast-1.amazonaws.com/dev/")
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = Method.get.rawValue
        
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(APIError.noData))
                    return
                }
                
                do {
                    // まず辞書形式でデコード
                    if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // "data" キーの配列部分を取り出す
                        if let locationsArray = jsonDict["data"] as? [[String: Any]] {
                            // JSONDecoderを使って配列をデコード
                            let jsonData = try JSONSerialization.data(withJSONObject: locationsArray, options: [])
                            let locations = try JSONDecoder().decode([MasterLocationData].self, from: jsonData)
                            
                            print(locations)
                            
                            completion(.success(locations))
                        } else {
                            completion(.failure(APIError.noData))
                        }
                    } else {
                        completion(.failure(APIError.noData))
                    }
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
            }
            
            task.resume()
        }
    }
}
