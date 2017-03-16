//
//  MovieTableViewself.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 15/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieName : UILabel!
    @IBOutlet var movieDetails : UILabel!
    @IBOutlet var releaseDate : UILabel!
    @IBOutlet var movieThumbnail : UIImageView!
    @IBOutlet var favoriteButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MovieTableViewCell {
    func configure(with movie : Movie) {
        self.movieName.text = movie.name
        self.movieDetails.text = movie.details
        
        self.releaseDate.text = movie.releaseDate.formattedString();
        
        if movie.isFavorite == true {
            self.favoriteButton.setImage(UIImage(named: "star_small"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "star_small_outline"), for: .normal)
        }
        
        self.movieThumbnail.loadImageFromURL(url: movie.thumbnail)
    }
}
