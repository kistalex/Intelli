//
//
// Intelli
// BannerData.swift
// 
// Created by Alexander Kist on 04.08.2023.
//


import Foundation


struct BannerData: Codable {
    let status: String
    let result: Result
}

struct Result: Codable {
    let title, actionTitle, selectedActionTitle: String
    let list: [List]
}

struct List: Codable {
    let id, title: String
    let description: String?
    let icon: Icon
    let price: String
    var isSelected: Bool
}

struct Icon: Codable {
    let the52X52: String

    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
