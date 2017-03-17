//
//  MovieListInteractor.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 3/17/16.
//  Copyright © 2017 Abhishek Sheth. All rights reserved.
//

import Foundation

class MovieListInteractor: MovieListUseCase {
    
    weak var output: MovieListInteractorOutput!
    
    func fetchMovies() {
        //Fetch from server
        
        //When done call
        //output.moviesFetched([movies])
    }
}
