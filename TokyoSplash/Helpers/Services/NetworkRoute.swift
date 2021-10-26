//
//  NetworkRoute.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import Foundation

enum NetworkRoute {
    case listPhotos(page: Int)
    case search(keyword: String, page: Int)
}

extension NetworkRoute: NetworkEndPoint {
    var method: HTTPMethods {
        switch self {
        case .listPhotos
            ,.search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .listPhotos:
            return "photos"
        case .search:
            return "search/photos"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .listPhotos(let page):
            return [
                "page": String(page)
            ]
        case .search(let keyword, let page):
            return [
                "page": String(page),
                "query": keyword
            ]
        }
    }
    
    var header: Headers? {
        switch self {
        case .listPhotos
            ,.search:
            return [
                "Authorization": "Client-ID "+Constant.accessKey
            ]
        }
    }
    var responseType: HTTPResponseType {
        switch self {
        case .listPhotos:
            return .array
        case .search:
            return .object
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
