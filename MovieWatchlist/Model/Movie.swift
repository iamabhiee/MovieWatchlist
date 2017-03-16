//
//  Movie.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 15/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class Movie: NSObject {
    var _id : String!
    var name : String!
    var details : String!
    var thumbnail : String!
    var releaseDate : Date!
    var isFavorite : Bool! = false
}

extension Movie {
    convenience init(with dictionary : [String:Any]) {
        self.init()
        if let movieId = dictionary["id"] as? String {
            self._id = movieId
        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let desc = dictionary["desc"] as? String {
            self.details = desc
        }
        
        if let image = dictionary["image"] as? String {
            self.thumbnail = image
        }
        
        if let favorite = dictionary["is_favorite"] as? String {
            self.isFavorite = favorite == "1"
        }
        
        if let date = dictionary["date"] as? String {
            let releaseDate = Date(timeIntervalSince1970: Double(date)!)
            self.releaseDate = releaseDate
        }
    }
}
