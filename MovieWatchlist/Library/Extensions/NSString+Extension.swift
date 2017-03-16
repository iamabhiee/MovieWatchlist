//
//  NSString+Extension.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 16/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation

extension Date {
    func formattedString() -> String! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let releaseDateString = dateFormatter.string(from: self)
        return releaseDateString;
    }
}
