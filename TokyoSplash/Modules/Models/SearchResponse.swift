//
//  SearchResponse.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 26/10/21.
//

import Foundation
// MARK: - SearcResponse
struct SearcResponse: Codable {
    let total, totalPages: Int?
    let results: [Photo]?

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
