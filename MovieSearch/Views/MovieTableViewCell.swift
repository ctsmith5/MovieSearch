//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Colin Smith on 3/22/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UITextView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    var movie: Movie? {
        didSet{
            updateViews()
            fetchAndUpdateImageView()
        }
    }

    
    
    func updateViews(){
        
        guard let movie = movie else {return}
        titleLabel.text = movie.title
        ratingLabel.text = "Rating\(movie.voteAverage)"
        overviewLabel.text = movie.overview
    }
    
    func fetchAndUpdateImageView() {
        guard let imagePath = movie?.imagePath else {return}
        MovieController.fetchImage(urlString: imagePath) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
