//
//  MovieListViewController.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 15/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class MovieListViewController: BaseTableViewController, UITableViewDataSource, UITableViewDelegate {
    lazy var movies : [Movie] = []
    var placeholderMessage : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Watchlist", style: .plain, target: self, action: #selector(actionWatchlist))
        
        //Register cell
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showProgressView()
        Alamofire.request("http://appbirds.co/movies/API/get_movies.php", method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let value):
                if let responseDictionary = value as? [String : Any] {
                    print(responseDictionary)
                    
                    if let movieList = responseDictionary["data"] as? [[String : Any]] {
                        self.movies.removeAll()
                        for movieDict in movieList {
                            let movie = Movie(with: movieDict)
                            self.movies.append(movie)
                        }
                    }
                    
                    if self.movies.count == 0 {
                        self.placeholderMessage = "Sorry, There are no upcoming movies :( "
                    } else {
                        self.placeholderMessage = nil
                    }
                }
                break
                
            case .failure(_):
                self.handleError(error: response.result.error)
                break
                
            }
            self.refreshTableView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.movies.count > 0 {
            return nil
        }
        
        return UIViewFactory.getPlaceholderView(with: placeholderMessage, parentView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (self.movies.count > 0) ? 0 : 100
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
    
    // MARK: - IBAction
    @IBAction func actionFavorite(_ sender : UIButton?) {
        guard let tag = sender?.tag else { return }
        let movie = self.movies[tag]
        
        var params : [String : Any] = [:]
        params["id"] = Int(movie._id)
        params["is_favorite"] = (!movie.isFavorite) ? 1 : 0
        self.showProgressView()
        Alamofire.request("http://appbirds.co/movies/API/update_favorite.php", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(let value):
                print(value)
                movie.isFavorite = !movie.isFavorite
            case .failure(_):
                self.handleError(error: response.result.error)
            }
            
            self.refreshTableView()
        }
    }
    
    @IBAction func actionWatchlist() {
        if let watchlistVC = self.storyboard?.instantiateViewController(withIdentifier: "WatchlistViewController") as? WatchlistViewController {
            self.navigationController?.pushViewController(watchlistVC, animated: true)
        }
    }
}
