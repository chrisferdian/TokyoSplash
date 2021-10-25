//
//  MainCollectionViewCell.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 24/10/21.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    fileprivate let placeholder = UIImage(named: "placeholder")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(with photo: Photo) {
        self.labelName.text = photo.user?.name
        self.labelDescription.text = photo.photoDescription
        if let urlString = photo.urls?.regular, let url = URL(string: urlString) {
            self.imageView.kf.indicatorType = .activity
            self.imageView.kf.setImage(
                with: url,
                placeholder: nil,
                options: [
                    .processor(DownsamplingImageProcessor(size: imageView.frame.size)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ]) { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        self.imageView.image = self.placeholder
                    }
                }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
