//
//  MovieDataSource.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 16/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

protocol MovieDataSourceDelegate {
    func didToggleFavorite(for index : Int)
}

class MovieDataSource: NSObject {
    lazy var movies : [Movie] = []
    weak var tableView : UITableView!
    var delegate : MovieDataSourceDelegate?
    
    
    convenience init(with tableView : UITableView) {
        self.init()
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        self.tableView = tableView
    }
    
    func movie(at index : Int) -> Movie {
        return self.movies[index]
    }
}

extension MovieDataSource : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell {
            let movie = self.movies[indexPath.row]
            cell.configure(with: movie)
            
            cell.favoriteButton.tag = indexPath.row
            cell.favoriteButton.addTarget(self, action: #selector(actionFavorite(_:)), for: .touchUpInside)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @IBAction func actionFavorite(_ sender : UIButton?) {
        if let tag = sender?.tag {
            self.delegate?.didToggleFavorite(for: tag)
        }
    }
}
