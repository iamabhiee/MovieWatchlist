//
//  MovieListContract.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 21/01/17.
//  Copyright © 2017 Abhishek Sheth. All rights reserved.
//

import UIKit

protocol MovieListView: class {
    var presenter: MovieListPresentation! { get set }
    
    func showNoContentScreen()
    func showMoviesData(_ movies: [Movie])
}

protocol MovieListPresentation: class {
    weak var view: MovieListView? { get set }
    var interactor: MovieListUseCase! { get set }
    var router: MovieListWireframe! { get set }
    
    func viewDidLoad()
    func didClickFavoriteButton()
}

protocol MovieListUseCase: class {
    weak var output: MovieListInteractorOutput! { get set }
    
    func fetchMovies()
}

protocol MovieListInteractorOutput: class {
    func moviesFetched(_ MovieList: [Movie])
    func moviesFetchFailed()
}

protocol MovieListWireframe: class {
    weak var viewController: UIViewController? { get set }
    
    static func assembleModule() -> UIViewController
}
