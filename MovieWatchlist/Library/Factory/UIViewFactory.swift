//
//  UIViewFactory.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 16/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class UIViewFactory: NSObject {
    class func getPlaceholderView(with message : String!, parentView : UIView!) -> UIView! {
        let padding = CGFloat(20.0)
        let label = UILabel(frame: CGRect(x: padding, y: 0, width: parentView.bounds.width - (padding * 2), height: 0))
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.text = message
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}
