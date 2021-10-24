//
//  BusinessWork.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 24/10/21.
//

import Foundation
// MARK: - BusinessWork
struct BusinessWork: Codable {
    let status: String?
    let approvedOn: String?

    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}
