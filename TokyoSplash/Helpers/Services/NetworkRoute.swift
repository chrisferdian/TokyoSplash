//
//  NetworkRoute.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import Foundation

enum NetworkRoute {
    case listPhotos(page: Int)
}

extension NetworkRoute: NetworkEndPoint {
    var method: HTTPMethods {
        switch self {
        case .listPhotos:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .listPhotos:
            return "photos"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .listPhotos(let page):
            return [
                "page": String(page)
            ]
        }
    }
    
    var header: Headers? {
        switch self {
        case .listPhotos:
            return [
                "Authorization": "Client-ID "+Constant.accessKey
            ]
        }
    }
    var responseType: HTTPResponseType {
        switch self {
        case .listPhotos:
            return .array
        }
    }
    func transform() -> URLComponents {
        var urlComponents = URLComponents(string: Constant.baseURL + path)!
        if method == .get {
            var queries:[URLQueryItem] = []
            parameter?.forEach { key, value in
                queries.append(URLQueryItem(name: key, value: value))
            }
            urlComponents.queryItems = queries
        }
        
        return urlComponents
    }
}
