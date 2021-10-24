//
//  TopicSubmissions.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 24/10/21.
//

import Foundation
// MARK: - TopicSubmissions
struct TopicSubmissions: Codable {
    let businessWork: BusinessWork?
    let architectureInterior, streetPhotography, foodDrink: ArchitectureInterior?
    let technology: BusinessWork?
    let fashion: ArchitectureInterior?

    enum CodingKeys: String, CodingKey {
        case businessWork = "business-work"
        case architectureInterior = "architecture-interior"
        case streetPhotography = "street-photography"
        case foodDrink = "food-drink"
        case technology, fashion
    }
}
