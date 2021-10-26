//
//  MainSearchUpdating.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 26/10/21.
//

import UIKit

class MainSearchUpdating: NSObject, UISearchResultsUpdating {
    var query: String = ""
    var didSearch : ((String) -> ())?

    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.query = searchController.searchBar.text ?? ""
        self.perform(#selector(reload), with: nil, afterDelay: 0.5)
    }
    @objc func reload() {
        if query.isEmpty {return}
        self.didSearch?(query)
    }
}
