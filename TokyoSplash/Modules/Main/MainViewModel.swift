//
//  MainViewModel.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 24/10/21.
//

import Foundation

class MainViewModel: NSObject {
    
    private let networkService: NetworkServices = NetworkServices.shared
    internal var photos: Photos = [] {
        didSet {
            self.bindPhotos?()
        }
    }
    
    var bindPhotos : (() -> ())?
    private var apiPage: Int = 1
    var isLoading: Bool = false
    var hasSearch: Bool = false
    
    func fetchPhotos(keyword: String? = nil) {
        if isLoading {return}
        var route: NetworkRoute = .listPhotos(page: apiPage)
        isLoading = true
        if hasSearch {
            guard let keyword = keyword else {
                return
            }
            route = .search(keyword: keyword, page: apiPage)
            self.processFetchSearchPhotos(route: route)
        } else {
            self.processFetchPhotos()
        }
    }
    private func processFetchSearchPhotos(route: NetworkRoute) {
        networkService.request(request: route, completion: { (result: Result<(SearcResponse?, [SearcResponse]?), Error>) in
            switch result {
            case .success(let value):
                if let searchResponse = value.0, let photosTemp = searchResponse.results {
                    if self.apiPage == 1 {self.photos.removeAll()}
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
    private func processFetchPhotos() {
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
    //MARK: Return number of property photos for collection view datasource
    func numberOfPhotos() -> Int {
        return self.photos.count
    }
    
    //MARK: Return single object of property photos for collection view datasource
    func photoAtIndexPath(index: Int) -> Photo {
        return photos[index]
    }
    
    func reloadPagination() {
        self.apiPage = 1
    }
}
