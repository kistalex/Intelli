//
//
// Intelli
// BannerData.swift
// 
// Created by Alexander Kist on 04.08.2023.
//


import Foundation


// MARK: - Result
struct BannerData: Codable {
    let status: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let title, actionTitle, selectedActionTitle: String
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let id, title: String
    let description: String?
    let icon: Icon
    let price: String
    let isSelected: Bool
}

// MARK: - Icon
struct Icon: Codable {
    let the52X52: String

    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
