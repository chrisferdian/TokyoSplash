//
//  NetworkServices.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import Foundation

class NetworkServices {
    
    //MARK: Properties
    private var session:URLSession!
    //Always use singleton share, so the applicantion not create new instance anymore
    static let shared = NetworkServices()
    
    //MARK: Functions
    /*
     Setup URLSession
     */
    func setConfigoration(configuration:URLSessionConfiguration? = nil) {
        guard configuration == nil else {
            self.session = URLSession(configuration: configuration!)
            return
        }
        
        //  default configuration goes here
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.timeoutIntervalForRequest = 4
        config.timeoutIntervalForResource = 4
        
        self.session = URLSession(configuration: config)
    }
    
    /*
     Request with tupple codable response
     - Single Object Codable
     - Array Object Codable
     */
    func request<T:Codable>(request:NetworkRoute,
                            completion:@escaping (Swift.Result<(T?, [T]?), Error>)->()) {
        //  set configuration object
        setConfigoration()
        
        
        //  build task and monitor
        var aRequest = URLRequest(url: request.transform().url!)
        if let headers = request.header {
            headers.forEach { aRequest.setValue($1, forHTTPHeaderField: $0) }
        }
        if request.method == .post {
            if let parameters = request.parameter {
                do {
                    aRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        let task = session?.dataTask(with: aRequest, completionHandler: { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                if request.responseType == .object {
                    let ip = try jsonDecoder.decode(T.self, from: data!)
                    completion(.success((ip, nil)))
                } else {
                    let ip = try jsonDecoder.decode([T].self, from: data!)
                    completion(.success((nil, ip)))
                }
            } catch {
                completion(.failure(error))
            }
        })
        
        //  fire network request
        task?.resume()
    }
}
