//
//  NetworkTypealias.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import Foundation

typealias Headers = Dictionary<String, String>
typealias Parameters = [String: String]

enum HTTPMethods: String {
    case get = "GET", post = "POST", delete = "DELETE", patch = "PATCH"
}

enum HTTPResponseType {
    case array
    case object
}
