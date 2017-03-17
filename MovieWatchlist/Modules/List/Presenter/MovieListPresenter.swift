//
//  MovieListPresenter.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 3/17/16.
//  Copyright © 2017 Abhishek Sheth. All rights reserved.
//

import Foundation

class MovieListPresenter: MovieListPresentation {
    
    weak var view: MovieListView?
    var interactor: MovieListUseCase!
    var router: MovieListWireframe!
    
    var movies: [Movie] = [] {
        didSet {
            if movies.count > 0 {
                view?.showMoviesData(movies)
            } else {
                view?.showNoContentScreen()
            }
        }
    }
    
    func viewDidLoad() {
        interactor.fetchMovies()
    }
    
    func didClickFavoriteButton() {
        
    }
}

extension MovieListPresenter: MovieListInteractorOutput {
    
    func moviesFetched(_ movies: [Movie]) {
        self.movies = movies
    }
    
    func moviesFetchFailed() {
        self.movies = []
    }
}
