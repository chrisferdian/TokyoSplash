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
    private var apiPage: Int = 1
    var isLoading: Bool = false
    
    func fetchPhotos() {
        if isLoading {
            return
        }
        isLoading = true
        networkService.request(request: .listPhotos(page: apiPage), completion: { (result: Result<(Photo?, [Photo]?), Error>) in
            switch result {
            case .success(let value):
                if let photosTemp = value.1 {
                    self.photos.append(contentsOf: photosTemp)
                    self.apiPage += 1
                    self.isLoading = false
                }
            case .failure(let error):
                self.isLoading = false
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
