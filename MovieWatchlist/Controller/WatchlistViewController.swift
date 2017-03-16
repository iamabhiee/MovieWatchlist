//
//  WatchlistViewController.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 15/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import Alamofire

class WatchlistViewController: BaseTableViewController {
    
    var datasource : MovieDataSource!
    lazy var emptyDataSource : EmptyDataSource = EmptyDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.datasource = MovieDataSource(with: self.tableView)
        self.datasource.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showProgressView()
        
        MovieServices.getWatchlist(success: { (movies) in
            self.hideProgressView()
            self.datasource.movies = movies
            
            self.refreshTableView()
        }, failure: { (error) in
            self.handleError(error: error)
        })
    }
    
    override func refreshTableView() {
        if self.datasource.movies.count == 0 {
            self.emptyDataSource.placeholderMessage = "Sorry, There are no movies in your watchlist :( "
            self.tableView.delegate = self.emptyDataSource
        } else {
            self.tableView.delegate = self.datasource
        }
        super.refreshTableView()
    }
}

extension WatchlistViewController : MovieDataSourceDelegate {
    func didToggleFavorite(for index: Int) {
        let movie = self.datasource.movie(at: index)
        
        self.showProgressView()
        MovieServices.updateWatchlist(movieId: movie._id, isFavorite: false, success: {(response) in
            self.datasource.movies.remove(at: index)
            self.refreshTableView()
        }, failure: { (error) in
            self.handleError(error: error)
        })
    }
}
