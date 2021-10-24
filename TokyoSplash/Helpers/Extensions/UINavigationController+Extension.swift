//
//  UINavigationController+Extension.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 24/10/21.
//

import UIKit

extension UINavigationController {
    func setNavigationBarAppearance(color: UIColor) {
        self.hideHairline()
        
        if #available(iOS 15.0, *){
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = color // The background color.
            
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
            
        } else { // Background color support for older versions
            self.navigationBar.barTintColor = color
            
        }
    }
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}
