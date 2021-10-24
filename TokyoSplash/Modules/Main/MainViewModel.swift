//
//  MainViewModel.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 24/10/21.
//

import Foundation

class MainViewModel: NSObject {
    
    private let networkService: NetworkServices = NetworkServices.shared
    var photos: Photos = [] {
        didSet {
            self.bindPhotos?()
        }
    }
    
    var bindPhotos : (() -> ())?
}
