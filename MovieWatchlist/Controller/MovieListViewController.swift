//
//  MovieListViewController.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 15/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class MovieListViewController: BaseTableViewController {
    var datasource : MovieDataSource!
    lazy var emptyDataSource : EmptyDataSource = EmptyDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Watchlist", style: .plain, target: self, action: #selector(actionWatchlist))
        
        self.datasource = MovieDataSource(with: self.tableView)
        self.datasource.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showProgressView()
        
        MovieServices.getMovies(success: { (movies) in
            self.hideProgressView()
            self.datasource.movies = movies
            
            self.refreshTableView()
        }, failure: { (error) in
            self.handleError(error: error)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func refreshTableView() {
        if self.datasource.movies.count == 0 {
            self.emptyDataSource.placeholderMessage = "Sorry, There are no upcoming movies :( "
            self.tableView.delegate = self.emptyDataSource
        } else {
            self.tableView.delegate = self.datasource
        }
        super.refreshTableView()
    }
    
    @IBAction func actionWatchlist() {
        if let watchlistVC = self.storyboard?.instantiateViewController(withIdentifier: "WatchlistViewController") as? WatchlistViewController {
            self.navigationController?.pushViewController(watchlistVC, animated: true)
        }
    }
}

extension MovieListViewController : MovieDataSourceDelegate {
    func didToggleFavorite(for index: Int) {
        let movie = self.datasource.movie(at: index)
        
        self.showProgressView()
        MovieServices.updateWatchlist(movieId: movie._id, isFavorite: !movie.isFavorite, success: {(response) in
            movie.isFavorite = !movie.isFavorite
            self.refreshTableView()
        }, failure: { (error) in
            self.handleError(error: error)
        })
    }
}
