//
//
// Intelli
// DataService.swift
// 
// Created by Alexander Kist on 11.08.2023.
//


import Foundation

class DataService {
    func fetchBannerData(fromFileNamed fileName: String, completion: @escaping (Swift.Result<BannerData, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let bannerData = try decoder.decode(BannerData.self, from: jsonData)
                completion(.success(bannerData))
            } catch {
                completion(.failure(error))
            }
        } else {
            let error = NSError(domain: "DataService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data file not found"])
            completion(.failure(error))
        }
    }
}
