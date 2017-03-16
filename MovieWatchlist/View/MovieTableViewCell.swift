//
//  MovieTableViewCell.swift
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
