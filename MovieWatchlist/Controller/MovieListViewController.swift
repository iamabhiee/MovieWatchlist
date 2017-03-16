//
//  MovieListViewController.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 15/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!
    lazy var movies : [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Watchlist", style: .plain, target: self, action: #selector(actionWatchlist))
        
        //Register cell
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        self.tableView.tableFooterView = UIView()

        //TODO : Pupulate data from server
        let movie1 = Movie()
        movie1.name = "Trapped"
        movie1.details = "A man gets stuck in an empty high rise without food, water and electricity."
        movie1.thumbnail = "Trapped_Poater"
        movie1.releaseDate = Date(timeIntervalSince1970: 1489708800)
        movies.append(movie1)
        
        let movie2 = Movie()
        movie2.name = "Naam Shabana"
        movie2.details = "It's a story of Character Shabana before the film Baby."
        movie2.thumbnail = "Naam_Shabana_Poster"
        movie2.releaseDate = Date(timeIntervalSince1970: 1490918400)
        movies.append(movie2)
        
        let movie3 = Movie()
        movie3.name = "Baahubali 2"
        movie3.details = "The movie which will answer Katappa ne Baahubali ko kyun maaara."
        movie3.thumbnail = "Baahubali_the_Conclusion"
        movie3.releaseDate = Date(timeIntervalSince1970: 1489708800)
        movies.append(movie3)
        
        self.tableView.reloadData()
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
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.bounds.width - 40, height: 0))
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.text = "Sorry, There are no upcoming movies :( "
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (self.movies.count > 0) ? 0 : 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell {
            let movie = self.movies[indexPath.row]
            
            cell.movieName.text = movie.name
            cell.movieDetails.text = movie.details
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            let releaseDateString = dateFormatter.string(from: movie.releaseDate)
            cell.releaseDate.text = releaseDateString;
            
            //TODO : Load Image From URL
            cell.movieThumbnail.image = UIImage(named: movie.thumbnail)
            
            if movie.isFavorite == true {
                cell.favoriteButton.setImage(UIImage(named: "star_small"), for: .normal)
            } else {
                cell.favoriteButton.setImage(UIImage(named: "star_small_outline"), for: .normal)
            }
            
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
        movie.isFavorite = !movie.isFavorite
        
        self.tableView.reloadData()
    }
    
    @IBAction func actionWatchlist() {
        if let watchlistVC = self.storyboard?.instantiateViewController(withIdentifier: "WatchlistViewController") as? WatchlistViewController {
            self.navigationController?.pushViewController(watchlistVC, animated: true)
        }
    }
}
