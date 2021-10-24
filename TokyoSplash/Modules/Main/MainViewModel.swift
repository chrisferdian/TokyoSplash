//
//  MainViewModel.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 24/10/21.
//

import Foundation

class MainViewModel: NSObject {
    
    private let networkService: NetworkServices = NetworkServices.shared
    private var photos: Photos = [] {
        didSet {
            self.bindPhotos?()
        }
    }
    
    var bindPhotos : (() -> ())?
    
    func fetchPhotos() {
        networkService.request(request: .listPhotos(page: 1), completion: { (result: Result<(Photo?, [Photo]?), Error>) in
            switch result {
            case .success(let value):
                if let photosTemp = value.1 {
                    self.photos = photosTemp
                    
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func numberOfPhotos() -> Int {
        return self.photos.count
    }
    
    func photoAtIndexPath(index: Int) -> Photo {
        return photos[index]
    }
}
