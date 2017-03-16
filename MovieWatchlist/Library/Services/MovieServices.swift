//
//  MovieServices.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 16/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class MovieServices: NSObject {
    class func getMovies(success:@escaping (_ movies : [Movie]) -> (), failure:@escaping (_ error : Error?) -> ()) {
        NetworkManager.sharedInstance.makePostRequest(path: "get_movies.php", parameters: [:], success: { (response) in
            if let movieList = response?["data"] as? [[String : Any]] {
                var movies : [Movie] = []
                for movieDict in movieList {
                    let movie = Movie(with: movieDict)
                    movies.append(movie)
                }
                success(movies)
            }
        }, failure: failure)
    }
    
    class func getWatchlist(success:@escaping (_ movies : [Movie]) -> (), failure:@escaping (_ error : Error?) -> ()) {
        NetworkManager.sharedInstance.makePostRequest(path: "get_favorite.php", parameters: [:], success: { (response) in
            if let movieList = response?["data"] as? [[String : Any]] {
                var movies : [Movie] = []
                for movieDict in movieList {
                    let movie = Movie(with: movieDict)
                    movies.append(movie)
                }
                success(movies)
            }
        }, failure: failure)
    }
    
    class func updateWatchlist(movieId : String!, isFavorite : Bool!, success:@escaping (_ response : Any) -> (), failure:@escaping (_ error : Error?) -> ()) {
        var params : [String : Any] = [:]
        params["id"] = Int(movieId)
        params["is_favorite"] = (isFavorite == true) ? 1 : 0
        
        NetworkManager.sharedInstance.makePostRequest(path: "update_favorite.php", parameters: params, success: { (response) in
            success(true)
        }, failure: failure)
    }
}
