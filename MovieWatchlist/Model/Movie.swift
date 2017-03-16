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
