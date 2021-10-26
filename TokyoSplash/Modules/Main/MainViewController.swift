//
//  MainViewController.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedViewType: UISegmentedControl!
    //MARK: Custom CollectionView layout for list and grid state
    lazy var collectionViewFlowLayout : TokyoCollectionLayout = {
        let layout = TokyoCollectionLayout(display: .grid)
        return layout
    }()
    private var viewModel: MainViewModel?
    //MARK: Clouser for navigate to Detail view
    internal var didNavigateToDetail : ((Photo) -> ())?
    internal var didNavigateToSearch : (() -> ())?
    lazy var searchBar:UISearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel = MainViewModel()
        viewModel?.bindPhotos = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        viewModel?.fetchPhotos()
    }
    private func setupUI() {

        searchBar.placeholder = "Find Any Images"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        collectionView.registerCell(MainCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionViewFlowLayout.display = .list
        self.navigationController?.setNavigationBarAppearance(color: .systemRed)
    }
    @objc func didTapSearch() {
        self.didNavigateToSearch?()
    }
    @IBAction func didTapSegmented(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            collectionViewFlowLayout.display = .list
            collectionViewFlowLayout.invalidateLayout()
        } else {
            collectionViewFlowLayout.display = .grid
            collectionViewFlowLayout.invalidateLayout()
        }
    }
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        self.viewModel?.hasSearch = true
        self.viewModel?.reloadPagination()
        self.viewModel?.fetchPhotos(keyword: query)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfPhotos() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MainCollectionViewCell.self.self, indexPath: indexPath)
        if let photo = self.viewModel?.photoAtIndexPath(index: indexPath.row) {
            cell.bind(with: photo)
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.searchBar.endEditing(true)
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !(self.viewModel?.isLoading ?? false), distance < 20 {
            viewModel?.fetchPhotos(keyword: self.searchBar.text)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photo = self.viewModel?.photoAtIndexPath(index: indexPath.row) {
            self.didNavigateToDetail?(photo)
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }
}
