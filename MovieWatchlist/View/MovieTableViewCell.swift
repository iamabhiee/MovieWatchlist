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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MovieTableViewCell {
    func configure(with movie : Movie) {
        self.movieName.text = movie.name
        self.movieDetails.text = movie.details
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let releaseDateString = dateFormatter.string(from: movie.releaseDate)
        self.releaseDate.text = releaseDateString;
        
        if movie.isFavorite == true {
            self.favoriteButton.setImage(UIImage(named: "star_small"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "star_small_outline"), for: .normal)
        }
        
        //Load Image From URL
        self.movieThumbnail.sd_showActivityIndicatorView()
        self.movieThumbnail.sd_setIndicatorStyle(.gray)
        self.movieThumbnail.sd_setImage(with: URL(string : movie.thumbnail))
    }
}
