//
//  TSEndPoint.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import Foundation

protocol NetworkEndPoint {
    var method: HTTPMethods { get }
    var path: String { get }
    var parameter: Parameters? { get }
    var header: Headers? { get }
    var responseType: HTTPResponseType {get}
    func transform() -> URLComponents
}
