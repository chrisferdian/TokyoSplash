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
        
        title = "写真"
        
        let searchBarItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        self.navigationItem.setRightBarButton(searchBarItem, animated: true)
        
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
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !(self.viewModel?.isLoading ?? false), distance < 20 {
            viewModel?.fetchPhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photo = self.viewModel?.photoAtIndexPath(index: indexPath.row) {
            self.didNavigateToDetail?(photo)
        }
    }
}
