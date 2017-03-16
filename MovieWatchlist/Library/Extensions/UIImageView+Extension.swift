//
//  UIImageView+Extension.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 16/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageFromURL(url : String) {
        if let imageURL = URL(string : url) {
            self.sd_showActivityIndicatorView()
            self.sd_setIndicatorStyle(.gray)
            self.sd_setImage(with: imageURL)
        }
    }
}
