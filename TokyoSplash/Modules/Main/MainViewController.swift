//
//  MainViewController.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedViewType: UISegmentedControl!
    
    lazy var collectionViewFlowLayout : TokyoCollectionLayout = {
        let layout = TokyoCollectionLayout(display: .grid)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "写真"
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.dataSource = self
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionViewFlowLayout.display = .list
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
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = .systemYellow
        return cell
    }
}
