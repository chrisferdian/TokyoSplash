//
//  DetailsViewController.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 25/10/21.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    //MARK: Properties
    var photo: Photo?
    
    @IBOutlet weak var imageView: UIImageView!
    
    // this is a convenient way to create this view controller without a imageURL
    convenience init() {
        self.init(photo: nil)
    }
    
    init(photo: Photo?) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
        
    // if this view controller is loaded from a storyboard, photo will be nil
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.imageView.enableZoom()
        if let urlString = photo?.urls?.regular, let url = URL(string: urlString) {
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
                        //MARK: set placeholder image if failed to load image from url
                        self.imageView.image = TSImage.placeholder
                    }
                }
        }
    }
}
