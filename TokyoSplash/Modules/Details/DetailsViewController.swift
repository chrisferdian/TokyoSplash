//
//  DetailsViewController.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 25/10/21.
//

import UIKit

class DetailsViewController: UIViewController {

    var photo: Photo?
    
    // this is a convenient way to create this view controller without a imageURL
    convenience init() {
        self.init(photo: nil)
    }
    
    init(photo: Photo?) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
        
    // if this view controller is loaded from a storyboard, imageURL will be nil
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
