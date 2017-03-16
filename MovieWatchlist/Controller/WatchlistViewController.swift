//
//  WatchlistViewController.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 15/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!
    lazy var movies : [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        self.tableView.tableFooterView = UIView()
        
        //TODO : Pupulate data from server
        let favoriteMovie = Movie()
        favoriteMovie.name = "Baahubali 2"
        favoriteMovie.details = "The movie which will answer Katappa ne Baahubali ko kyun maaara."
        favoriteMovie.thumbnail = "Baahubali_the_Conclusion"
        favoriteMovie.releaseDate = Date(timeIntervalSince1970: 1489708800)
        favoriteMovie.isFavorite = true
        movies.append(favoriteMovie)
        
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
        label.text = "Seems like you are very busy, You don't have any plans to watch movie in distant future :( "
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
        self.movies.remove(at: tag)
        
        self.tableView.reloadData()
    }
}
